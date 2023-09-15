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
 * along with Traefik Terraform module.  If not, see <http://www.gnu.org/licenses/>.
 */

resource "kubernetes_manifest" "default_middleware" {
  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/default.yaml.tpl",
    {
      name             = var.helm_release.name
      namespace        = module.generic.namespace
      security_headers = var.security_headers
    }
  ))

  depends_on = [
    module.generic
  ]
}

locals {
  from_non_www_to_www_redirects = { for value in var.ingress_routes :
    value.namespace => value.redirect.from_non_www_to_www...
  }
  from_www_to_non_www_redirects = { for value in var.ingress_routes :
    value.namespace => value.redirect.from_www_to_non_www...
  }
}

resource "kubernetes_manifest" "from_non_www_to_www_redirects_middleware" {
  for_each = toset([for namespace, values in local.from_non_www_to_www_redirects : namespace if anytrue(values)])

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/from-non-www-to-www-redirect.yaml.tpl",
    {
      namespace = each.value
    }
  ))

  depends_on = [
    module.generic
  ]
}

resource "kubernetes_manifest" "from_www_to_non_www_redirects_middleware" {
  for_each = toset([for namespace, values in local.from_www_to_non_www_redirects : namespace if anytrue(values)])

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/from-www-to-non-www-redirect.yaml.tpl",
    {
      namespace = each.value
    }
  ))

  depends_on = [
    module.generic
  ]
}
