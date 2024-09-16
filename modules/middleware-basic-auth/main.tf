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
  name = "${var.metadata.name}-basic-auth"
}

resource "kubernetes_secret" "basic_auth" {
  metadata {
    name      = local.name
    namespace = var.metadata.namespace
  }

  data = {
    username = var.username
    password = var.password
  }

  type = "kubernetes.io/basic-auth"
}

module "basic_auth_middleware" {
  source = "../middleware"

  metadata = {
    name      = local.name
    namespace = var.metadata.namespace
  }

  spec = yamldecode(templatefile(
    "${path.module}/templates/manifests/spec-basic-auth.yaml.tpl",
    { name = local.name }
  ))
}
