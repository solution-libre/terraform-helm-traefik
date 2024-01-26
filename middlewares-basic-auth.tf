/**
 * Copyright (C) 2023-2024 Solution Libre <contact@solution-libre.fr>
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
  middlewares_basic_auth = merge([for name, basic_auth in nonsensitive(var.middlewares_basic_auth) :
    {
      for ingress_route in basic_auth.ingress_routes :
      "${var.ingress_routes[ingress_route].namespace}/${name}" => merge(
        {
          name      = name
          namespace = var.ingress_routes[ingress_route].namespace
        },
        { for k, v in basic_auth : k => v }
      )
    }
  ]...)
}

resource "kubernetes_secret" "basic_auth" {
  for_each = local.middlewares_basic_auth

  metadata {
    name      = "${each.value.name}-basic-auth"
    namespace = each.value.namespace
  }

  data = {
    username = each.value.username
    password = each.value.password
  }

  type = "kubernetes.io/basic-auth"
}

resource "kubernetes_manifest" "middlewares_basic_auth" {
  for_each = local.middlewares_basic_auth

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/basic-auth.yaml.tpl",
    {
      name      = each.value.name
      namespace = each.value.namespace
    }
  ))

  depends_on = [module.generic]
}
