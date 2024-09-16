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

module "basic_auth_middleware" {
  source = "./modules/middleware-basic-auth"

  for_each = merge([for name, basic_auth in nonsensitive(var.middlewares_basic_auth) :
    {
      for ingress_route in basic_auth.ingress_routes :
      "${var.ingress_routes[ingress_route].metadata.namespace}/${name}" => merge(
        {
          name      = name
          namespace = var.ingress_routes[ingress_route].metadata.namespace
        },
        { for k, v in basic_auth : k => v }
      )
    ... }
  ]...)

  metadata = {
    name      = each.value[0].name
    namespace = each.value[0].namespace
  }

  username = each.value[0].username
  password = each.value[0].password

  depends_on = [module.generic]
}
