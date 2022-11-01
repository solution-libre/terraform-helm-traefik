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
  version = "0.1.0"

  helm_release   = var.helm_release
  labels_prefix  = var.labels_prefix
  namespace      = var.namespace
  network_policy = var.network_policy
}

resource "kubernetes_network_policy" "traefik_allow_ingress" {
  count = var.network_policy.enabled ? 1 : 0

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
        port     = "http"
        protocol = "TCP"
      }
      ports {
        port     = "https"
        protocol = "TCP"
      }

      dynamic "from" {
        for_each = var.network_policy.ingress_cidrs
        content {
          ip_block {
            cidr = from.value
          }
        }
      }
    }

    policy_types = ["Ingress"]
  }
}
