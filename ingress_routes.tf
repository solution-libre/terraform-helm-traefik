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

resource "kubernetes_manifest" "ingress_routes" {
  for_each = var.ingress_routes

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/ingress-route.yaml.tpl",
    merge(
      { name = each.key },
      { for k, v in each.value : k => v },
      {
        middlewares = concat(
          compact([for name, values in nonsensitive(var.middlewares_basic_auth) : (contains(values.ingress_routes, each.key) ? "${name}-basic-auth" : null)]),
          compact([for name, values in var.middlewares.strip_prefix : (contains(values.ingress_routes, each.key) ? "${name}-strip-prefix" : null)])
        )
      }
    )
  ))

  depends_on = [
    module.generic
  ]
}

moved {
  from = kubernetes_manifest.ingress_route
  to   = kubernetes_manifest.ingress_routes
}

resource "kubernetes_manifest" "tls_options" {
  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/tls-options.yaml.tpl",
    {
      name      = var.helm_release.name
      namespace = module.generic.namespace
    }
  ))
}
