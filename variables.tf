variable "helm_release" {
  default     = {}
  description = "Traefik Helm release customization"
  type = object({
    chart               = optional(string, "traefik")
    chart_version       = optional(string, "17.0.5")
    extra_values        = optional(list(string), [])
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
    middlewares  = optional(list(string), [])
    service_name = string
    service_port = number
    www_redirect = optional(bool, false)
  }))
}

variable "namespace" {
  default     = {}
  description = "Traefik namespace customization"
  type = object({
    create = optional(bool, true)
    name   = optional(string, "traefik")
  })
}

variable "network_policies" {
  default     = {}
  description = "Traefik network policies customization"
  type = object({
    allow_ingress_enabled    = optional(bool, true)
    allow_monitoring_enabled = optional(bool, false)
    allow_namespace_enabled  = optional(bool, true)
    default_deny_enabled     = optional(bool, true)
    ingress_cidrs            = optional(list(string), ["0.0.0.0/0"])
  })
}

variable "security_headers" {
  default     = {}
  description = "Traefik security headers customization"
  type = object({
    frame_deny           = optional(bool, false)
    browser_xss_filter   = optional(bool, true)
    content_type_nosniff = optional(bool, true)
    sts = optional(object({
      include_subdomains = optional(bool, true)
      seconds            = optional(number, 315360000)
      preload            = optional(bool, true)
    }), {})
  })
}
