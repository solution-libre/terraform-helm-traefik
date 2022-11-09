variable "helm_release" {
  default = {
    chart         = "traefik"
    chart_version = "17.0.5"
    name          = "traefik"
    repository    = "https://helm.traefik.io/traefik"
    timeout       = 900
  }
  description = "Traefik Helm release customization"
  type = object({
    extra_values        = optional(string)
    chart               = optional(string, "traefik")
    chart_version       = optional(string, "17.0.5")
    name                = optional(string, "traefik")
    repository          = optional(string, "https://helm.traefik.io/traefik")
    timeout             = optional(number, 900)
    service_annotations = optional(string)
  })
}

variable "labels_prefix" {
  default     = "solution-libre.fr"
  description = "Custom label prefix used for network policy namespace matching"
  type        = string
}

variable "namespace" {
  default = {
    create = true
    name   = "traefik"
  }
  description = "Traefik namespace customization"
  type = object({
    create = optional(bool, true)
    name   = optional(string, "traefik")
  })
}

variable "network_policy" {
  default = {
    enabled       = true
    ingress_cidrs = ["0.0.0.0/0"]
  }
  description = "Traefik network policy customization"
  type = object({
    enabled       = optional(bool, true)
    ingress_cidrs = optional(list(string), ["0.0.0.0/0"])
  })
}