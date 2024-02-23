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

moved {
  from = kubernetes_manifest.default_middleware
  to   = module.default_middleware.kubernetes_manifest.this
}

module "default_middleware" {
  source = "./modules/middleware"

  metadata = {
    name      = "${var.helm_release.name}-default"
    namespace = module.generic.namespace
  }

  spec = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares-spec/default.yaml.tpl",
    {

      security_headers = var.security_headers
    }
  ))

  depends_on = [module.generic]
}
