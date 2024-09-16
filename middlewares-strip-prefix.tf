/**
 * Copyright (C) 2024 Solution Libre <contact@solution-libre.fr>
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

module "strip_prefix_middleware" {
  source = "./modules/middleware-strip-prefix"

  for_each = merge([for name, strip_prefix in var.middlewares.strip_prefix :
    {
      for ingress_route in strip_prefix.ingress_routes :
      "${var.ingress_routes[ingress_route].metadata.namespace}/${name}" => merge(
        {
          name      = name
          namespace = var.ingress_routes[ingress_route].metadata.namespace
        },
        { for k, v in strip_prefix : k => v }
      )...
    }
  ]...)

  metadata = {
    name      = "${each.value[0].name}-strip-prefix"
    namespace = each.value[0].namespace
  }

  force_slash = each.value[0].force_slash
  prefixes    = each.value[0].prefixes

  depends_on = [module.generic]
}
