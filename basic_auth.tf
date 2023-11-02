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

resource "kubernetes_secret" "basic_auth" {
  for_each = nonsensitive(var.ingress_routes_basic_auth)

  metadata {
    name      = "${each.key}-basic-auth"
    namespace = var.ingress_routes[each.key].namespace
  }

  data = {
    username = each.value.username
    password = each.value.password
  }

  type = "kubernetes.io/basic-auth"
}

resource "kubernetes_manifest" "middlewares_basic_auth" {
  for_each = nonsensitive(var.ingress_routes_basic_auth)

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/basic-auth.yaml.tpl",
    {
      name      = each.key
      namespace = var.ingress_routes[each.key].namespace
    }
  ))

  depends_on = [module.generic]
}
