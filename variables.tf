variable "deployment" {
  default     = {}
  description = "Traefik deployment configuration"
  type = object({
    enabled  = optional(bool, true)           # Enable deployment
    kind     = optional(string, "Deployment") # Deployment or DaemonSet
    replicas = optional(number, 1)            # Number of pods of the deployment (only applies when kind == Deployment)
  })
}

variable "helm_release" {
  default     = {}
  description = "Traefik Helm release configuration"
  type = object({
    chart         = optional(string, "traefik")                         # Chart name to be installed
    chart_version = optional(string, "17.0.5")                          # Specify the exact chart version to install
    extra_values  = optional(list(string), [])                          # List of extra values in raw yaml to pass to helm
    name          = optional(string, "traefik")                         # Release name
    repository    = optional(string, "https://helm.traefik.io/traefik") # Repository URL where to locate the requested chart
    timeout       = optional(number, 900)                               # Time in seconds to wait for any individual kubernetes operation
  })
}

variable "ingress_routes" {
  default     = {}
  description = "Map of ingress routes"
  type = map(object({
    hostname    = string
    namespace   = string
    middlewares = optional(list(string), [])
    redirect = optional(object({
      from_non_www_to_www = optional(bool, false)
      from_www_to_non_www = optional(bool, false)
    }), {})
    service = object({
      name   = string
      port   = number
      sticky = optional(bool, false)
    })
  }))

  validation {
    condition     = (lookup(var.ingress_routes, "redirect", null) == null) ? true : !alltrue([var.ingress_routes.redirect.from_non_www_to_www, var.ingress_routes.redirect.from_www_to_non_www])
    error_message = "Both `from_non_www_to_www` and `from_www_to_non_www` are set to true (but are exclusive)."
  }
}

variable "ingress_routes_tcp" {
  default     = {}
  description = "Map of ingress routes TCP"
  type = map(object({
    entry_point = object({
      name = string
      port = number
    })
    namespace = string
    proxy_protocol = optional(object({
      enabled = optional(bool, false)
      version = optional(number, 2)
    }))
    service = object({
      name = string
      port = number
    })
    tls = optional(object({
      enabled     = optional(bool, false)
      secret_name = string
    }))
  }))
}

variable "ports" {
  default     = {}
  description = "Traefik ports configuration"
  type = object({
    lb_ip                     = optional(string, "") # The IP address of the kubernetes provider's LoadBalancer
    http_to_https_redirection = optional(bool, true) # Permanent redirect from HTTP to HTTPs
  })
}

variable "namespace" {
  default     = {}
  description = "Traefik namespace configuration"
  type = object({
    create = optional(bool, true)        # Create the namespace if it does not yet exist
    name   = optional(string, "traefik") # The namespace to install the release into
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
    annotations      = optional(map(string), {}) # Additional annotations applied to both TCP and UDP services
    ip_family_policy = optional(string)          # One of SingleStack, PreferDualStack, or RequireDualStack
  })
}

variable "kubernetes_providers" {
  default     = {}
  description = "Traefik provides configuration"
  type = object({
    crd = optional(object({
      enabled                      = optional(bool, true)  # Load Kubernetes IngressRoute provider
      allow_cross_namespace        = optional(bool, false) # Allows IngressRoute to reference resources in namespace other than theirs
      allow_external_name_services = optional(bool, false) # Allows to reference ExternalName services in IngressRoute
      allow_empty_services         = optional(bool, false) # Allows to return 503 when there is no endpoints available
    })),
    ingress = optional(object({
      enabled                      = optional(bool, true)  # Load Kubernetes IngressRoute provider
      allow_external_name_services = optional(bool, false) # Allows to reference ExternalName services in Ingress
      allow_empty_services         = optional(bool, false) # Allows to return 503 when there is no endpoints available
    }))
  })

}
