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

locals {
  values = merge([for name, custom in var.middlewares.custom : {
    for ingress_route in custom.ingress_routes :
    "${var.ingress_routes[ingress_route].metadata.namespace}/${name}" => merge(
      {
        name      = name
        namespace = var.ingress_routes[ingress_route].metadata.namespace
      },
      { for k, v in custom : k => v }
    )...
    }
  ]...)
}


module "custom_middleware" {
  source = "./modules/middleware"

  for_each = local.values

  metadata = {
    name      = "${each.value[0].name}-custom"
    namespace = each.value[0].namespace
  }

  spec = each.value[0].spec

  depends_on = [module.generic]
}

output "values" {
  value = local.values
}
