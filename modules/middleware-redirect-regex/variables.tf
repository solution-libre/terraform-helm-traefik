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
  description = "Traefik middleware Redirect Regex metadata"
  type = object({
    name      = string
    namespace = optional(string, "default")
  })
}

variable "permanent" {
  default     = false
  description = "Set the permanent option to true to apply a permanent redirection"
  type        = bool
}

variable "regex" {
  description = "The regular expression to match and capture elements from the request URL"
  type        = string
}

variable "replacement" {
  description = "How to modify the URL to have the new target URL"
  type        = string
}
