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

variable "ingress" {
  default     = {}
  description = "Map of ingress"
  type = map(object({
    hostname     = string
    namespace    = string
    service_name = string
    service_port = number
    www_redirect = optional(bool, false)
  }))
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

variable "network_policies" {
  default = {
    enabled       = true
    ingress_cidrs = ["0.0.0.0/0"]
  }
  description = "Traefik network policy customization"
  type = object({
    allow_ingress_enabled    = optional(bool, true)
    allow_monitoring_enabled = optional(bool, false)
    allow_namespace_enabled  = optional(bool, true)
    cert_manager = optional(object({
      enabled   = optional(bool, false)
      name      = optional(string, "cert-manager")
      namespace = optional(string, "cert-manager")
    }), {})
    default_deny_enabled = optional(bool, true)
    ingress_cidrs        = optional(list(string), ["0.0.0.0/0"])
  })
}
