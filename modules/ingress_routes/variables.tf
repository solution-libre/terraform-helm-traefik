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

variable "metadata" {
  description = "Traefik ingress route metadata"
  type = object({
    name      = string
    namespace = optional(string, "default")
  })
}

variable "spec" {
  description = "Traefik ingress route specifications"
  type = object({
    entry_points = optional(list(string), ["websecure"])
    routes = object({
      match = object({
        hosts         = list(string)
        paths         = optional(list(string), [])
        path_prefixes = optional(list(string), [])
      })
      middlewares = optional(list(string), [])
      priority    = optional(number)
      service = object({
        name   = string
        port   = number
        sticky = optional(bool, false)
      })
      tls = object({
        secret_name = string
      })
    })
  })
}
