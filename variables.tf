variable "deployment" {
  default     = {}
  description = "Traefik deployment configuration"
  type = object({
    enabled  = optional(bool, true)
    kind     = optional(string, "Deployment")
    replicas = optional(number, 1)
  })
}

variable "helm_release" {
  default     = {}
  description = "Traefik Helm release configuration"
  type = object({
    chart         = optional(string, "traefik")
    chart_version = optional(string, "17.0.5")
    extra_values  = optional(list(string), [])
    name          = optional(string, "traefik")
    repository    = optional(string, "https://helm.traefik.io/traefik")
    timeout       = optional(number, 900)
  })
}

variable "ingress" {
  default     = {}
  description = "Map of ingress"
  type = map(object({
    hostname    = string
    namespace   = string
    middlewares = optional(list(string), [])
    redirect = optional(object({
      from_non_www_to_www = optional(bool, false)
      from_www_to_non_www = optional(bool, false)
    }), {})
    service_name = string
    service_port = number
  }))

  validation {
    condition     = (lookup(var.ingress, "redirect", null) == null) ? true : !alltrue([var.ingress.redirect.from_non_www_to_www, var.ingress.redirect.from_www_to_non_www])
    error_message = "Both `from_non_www_to_www` and `from_www_to_non_www` are set to true (but are exclusive)."
  }
}

variable "lb_ip" {
  default     = ""
  description = "The IP address of the kubernetes provider's LoadBalancer"
  type        = string
}

variable "namespace" {
  default     = {}
  description = "Traefik namespace configuration"
  type = object({
    create = optional(bool, true)
    name   = optional(string, "traefik")
  })
}

variable "network_policies" {
  default     = {}
  description = "Traefik network policies configuration"
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
  description = "Traefik security headers configuration"
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

variable "service" {
  default     = {}
  description = "Traefik service configuration"
  type = object({
    annotations      = optional(map(string), {})
    ip_family_policy = optional(string)
  })
}
