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

module "ingress_routes" {
  source = "./modules/ingress-route"

  for_each = var.ingress_routes

  metadata = {
    name      = each.key
    namespace = each.value.namespace
  }

  spec = {
    entry_points = ["websecure"]
    routes = merge(
      { for k, v in each.value : k => v },
      {
        middlewares = concat(
          each.value.redirects.from_non_www_to_www ? ["from-non-www-to-www-redirect"] : [],
          each.value.redirects.from_www_to_non_www ? ["from-www-to-non-www-redirect"] : [],
          [for name, regex in each.value.redirects.regex : "${name}-redirect"],
          compact([
            for name, values in nonsensitive(var.middlewares_basic_auth) :
            (contains(values.ingress_routes, each.key) ? "${name}-basic-auth" : null)
          ]),
          compact([
            for name, values in var.middlewares.strip_prefix :
            (contains(values.ingress_routes, each.key) ? "${name}-strip-prefix" : null)
          ])
        )
      }
    )
  }

  depends_on = [
    module.generic
  ]
}

moved {
  from = kubernetes_manifest.ingress_route
  to   = kubernetes_manifest.ingress_routes
}
