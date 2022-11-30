locals {
  values = templatefile(
    "${path.module}/templates/values.yaml.tpl",
    {
      service_annotations = var.helm_release.service_annotations
    }
  )
}

module "generic" {
  source  = "usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/generic/helm"
  version = "0.2.0"

  helm_release     = var.helm_release
  namespace        = var.namespace
  network_policies = var.network_policies
  values           = local.values
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
      name         = each.key
      namespace    = each.value.namespace
      hostname     = each.value.hostname
      service_name = each.value.service_name
      service_port = each.value.service_port
      www_redirect = each.value.www_redirect
    }
  ))

  depends_on = [
    module.generic
  ]
}
