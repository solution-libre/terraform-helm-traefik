module "generic" {
  source  = "solution-libre/generic/helm"
  version = "0.4.1"

  helm_release     = var.helm_release
  namespace        = var.namespace
  network_policies = var.network_policies

  values = templatefile(
    "${path.module}/templates/values.yaml.tpl",
    {
      deployment = var.deployment
      lb_ip      = var.lb_ip
      name       = var.helm_release.name
      namespace  = var.namespace.name
      service    = var.service
    }
  )
}

resource "kubernetes_network_policy" "traefik_allow_ingress" {
  count = var.network_policies.allow_ingress_enabled ? 1 : 0

  metadata {
    name      = "${module.generic.namespace}-allow-ingress"
    namespace = module.generic.namespace
  }

  spec {
    pod_selector {
      match_expressions {
        key      = "app.kubernetes.io/name"
        operator = "In"
        values   = ["traefik"]
      }
    }

    ingress {
      ports {
        port     = 8000
        protocol = "TCP"
      }
      ports {
        port     = 8443
        protocol = "TCP"
      }

      dynamic "from" {
        for_each = var.network_policies.ingress_cidrs
        content {
          ip_block {
            cidr = from.value
          }
        }
      }

      from {
        namespace_selector {
        }
      }
    }

    policy_types = ["Ingress"]
  }
}

resource "kubernetes_manifest" "ingress_route" {
  for_each = var.ingress

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/ingress-route.yaml.tpl",
    {
      access_control_enabled = each.value.access_control.enabled
      name                   = each.key
      namespace              = each.value.namespace
      middlewares            = each.value.middlewares
      hostname               = each.value.hostname
      service_name           = each.value.service_name
      service_port           = each.value.service_port
      redirect               = each.value.redirect
    }
  ))

  depends_on = [
    module.generic
  ]
}

resource "kubernetes_manifest" "tls_options" {
  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/tls-options.yaml.tpl",
    {
      name      = var.helm_release.name
      namespace = module.generic.namespace
    }
  ))
}
