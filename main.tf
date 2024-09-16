/**
 * Copyright (C) 2022-2023 Solution Libre <contact@solution-libre.fr>
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

module "generic" {
  source  = "solution-libre/generic/helm"
  version = "0.6.0"

  helm_release     = var.helm_release
  namespace        = var.namespace
  network_policies = var.network_policies

  values = templatefile(
    "${path.module}/templates/values.yaml.tpl",
    {
      deployment           = var.deployment
      experimental         = var.experimental
      ingress_routes_tcp   = var.ingress_routes_tcp
      logs                 = var.logs
      metrics              = var.metrics
      ports                = var.ports
      name                 = var.helm_release.name
      namespace            = var.namespace.name
      service              = var.service
      kubernetes_providers = var.kubernetes_providers
    }
  )
}
