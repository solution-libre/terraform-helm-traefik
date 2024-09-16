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

module "redirect_regex_middleware" {
  source = "./modules/middleware-redirect-regex"

  for_each = merge(flatten([
    for key, ingress_route in var.ingress_routes :
    merge(
      (ingress_route.redirects.from_non_www_to_www) ? {
        "${ingress_route.metadata.namespace}/from-non-www-to-www" = {
          permanent   = true
          regex       = "^https?://(?:www\\.)?(.+)"
          replacement = "https://www.$1"
        }
      } : {},
      (ingress_route.redirects.from_www_to_non_www) ? {
        "${ingress_route.metadata.namespace}/from-www-to-non-www" = {
          permanent   = true
          regex       = "^https?://www\\.(.+)"
          replacement = "https://$1"
        }
      } : {},
      {
        for name, redirect_regex in ingress_route.redirects.regex :
        "${ingress_route.metadata.namespace}/${name}" => redirect_regex
      }
    )
  ])...)

  metadata = {
    name      = split("/", each.key)[1]
    namespace = split("/", each.key)[0]
  }

  permanent   = each.value.permanent
  regex       = each.value.regex
  replacement = each.value.replacement

  depends_on = [module.generic]
}
