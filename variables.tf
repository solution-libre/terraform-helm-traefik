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
    chart_version = optional(string, "20.8.0")                          # Specify the exact chart version to install
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
    match = object({
      hosts         = list(string)
      paths         = optional(list(string), [])
      path_prefixes = optional(list(string), [])
    })
    namespace   = string
    middlewares = optional(list(string), [])
    priority    = optional(number)
    redirects = optional(object({
      from_non_www_to_www = optional(bool, false)
      from_www_to_non_www = optional(bool, false)
      regex = optional(map(object({
        permanent   = optional(bool, false)
        regex       = string
        replacement = string
      })), {})
    }), {})
    service = object({
      name   = string
      port   = number
      sticky = optional(bool, false)
    })
    tls = object({
      secret_name = string
    })
  }))

  validation {
    condition     = (lookup(var.ingress_routes, "redirect", null) == null) ? true : !alltrue([var.ingress_routes.redirect.from_non_www_to_www, var.ingress_routes.redirect.from_www_to_non_www])
    error_message = "Both `from_non_www_to_www` and `from_www_to_non_www` are set to true (but are exclusive)."
  }
}

variable "ingress_routes_basic_auth" {
  default     = {}
  description = "Map of ingress routes Basic Authentication"
  sensitive   = true
  type = map(object({
    password = string
    username = string
  }))
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

variable "logs" {
  default     = {}
  description = "Traefik logs configuration"
  type = object({
    general = optional(object({
      level = optional(string, "ERROR") # Logging levels
    }), {})
  })

  validation {
    condition     = contains(["DEBUG", "PANIC", "FATAL", "ERROR", "WARN", "INFO"], var.logs.general.level)
    error_message = "Logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO."
  }
}

variable "metrics" {
  default     = {}
  description = "Traefik metrics configuration"
  type = object({
    prometheus = optional(object({
      enabled     = optional(bool, true)
      entry_point = optional(string, "metrics") # Entry point used to expose metrics
      service = optional(object({
        enabled = optional(bool, false) # Create a dedicated metrics service for use with ServiceMonitor
      }), {})
      service_monitor = optional(object({
        enabled = optional(bool, false)
      }), {})
    }), {})
  })
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
    egress = optional(object({
      allow = optional(object({
        within_namespace = optional(bool, false) # Allow egress traffic within the namespace
      }), {})
      default = optional(object({
        allow_all = optional(bool, false) # By default, allow all egress traffic
        deny_all  = optional(bool, false) # By default, deny all egress traffic
      }), {})
    }), {})
    ingress = optional(object({
      allow = optional(object({
        external = optional(object({
          enabled    = optional(bool, true)                  # Allowing external ingress
          from_cidrs = optional(list(string), ["0.0.0.0/0"]) # From these CIDRs
        }), {})
        monitoring_namespace = optional(bool, false) # Allow ingress traffic from the namespace named monitoring
        within_namespace     = optional(bool, false) # Allow ingress traffic within the namespace
      }), {})
      default = optional(object({
        allow_all = optional(bool, false) # By default, allow all ingress traffic
        deny_all  = optional(bool, false) # By default, deny all ingress traffic
      }), {})
    }), {})
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
