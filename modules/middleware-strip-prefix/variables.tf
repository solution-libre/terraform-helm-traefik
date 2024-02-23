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
  description = "Traefik middleware Strip Prefix metadata"
  type = object({
    name      = string
    namespace = optional(string, "default")
  })
}

variable "force_slash" {
  default     = null
  description = "The resulting stripped path is not the empty string, by replacing it with / when necessary"
  type        = bool
}

variable "prefixes" {
  description = "The prefixes to strip from the request URL"
  type        = set(string)
}
