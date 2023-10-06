/**
 * Copyright (C) 2023 Solution Libre <contact@solution-libre.fr>
 * 
 * This file is part of Traefik Terraform module.
 * 
 * Traefik Terraform module is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 * 
 * Traefik Terraform module is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 * 
 * You should have received a copy of the GNU General Public License
 * along with Traefik Terraform module.  If not, see <https://www.gnu.org/licenses/>.
 */

locals {
  ingress_ports = concat(
    [8000, 8443],
    [for value in var.ingress_routes_tcp : value.entry_point.port]
  )
}

resource "kubernetes_network_policy" "traefik_allow_ingress" {
  count = var.network_policies.ingress.allow.external.enabled ? 1 : 0

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
        for_each = var.network_policies.ingress.allow.external.from_cidrs
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
