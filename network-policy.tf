locals {
  ingress_ports = concat(
    [8000, 8443],
    [for value in var.ingress_routes_tcp : value.entry_point.port]
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
      dynamic "ports" {
        for_each = local.ingress_ports
        content {
          port     = ports.value
          protocol = "TCP"
        }
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
