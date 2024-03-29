# Reference

<!-- markdownlint-disable MD033 MD013 -->

<!-- DO NOT EDIT: This document was generated by terraform-docs -->

<!-- BEGIN_TF_DOCS -->
Copyright (C) 2022-2023 Solution Libre <contact@solution-libre.fr>

This file is part of Traefik Terraform module.

Traefik Terraform module is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation, either version 3 of the License, or
(at your option) any later version.

Traefik Terraform module is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with Traefik Terraform module.  If not, see <https://www.gnu.org/licenses/>.

## Requirements

| Name | Version |
|------|---------|
| <a name="requirement_terraform"></a> [terraform](#requirement\_terraform) | >= 1.3.0 |
| <a name="requirement_kubernetes"></a> [kubernetes](#requirement\_kubernetes) | ~> 2.0 |

## Providers

| Name | Version |
|------|---------|
| <a name="provider_kubernetes"></a> [kubernetes](#provider\_kubernetes) | ~> 2.0 |

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_generic"></a> [generic](#module\_generic) | solution-libre/generic/helm | 0.6.0 |

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.default_middleware](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ingress_routes](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.ingress_routes_tcp](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.middlewares_basic_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.middlewares_redirect_regex](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_manifest.tls_options](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |
| [kubernetes_network_policy.traefik_allow_ingress](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/network_policy) | resource |
| [kubernetes_secret.basic_auth](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/secret) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_deployment"></a> [deployment](#input\_deployment) | Traefik deployment configuration | <pre>object({<br>    enabled  = optional(bool, true)           # Enable deployment<br>    kind     = optional(string, "Deployment") # Deployment or DaemonSet<br>    replicas = optional(number, 1)            # Number of pods of the deployment (only applies when kind == Deployment)<br>  })</pre> | `{}` | no |
| <a name="input_helm_release"></a> [helm\_release](#input\_helm\_release) | Traefik Helm release configuration | <pre>object({<br>    chart         = optional(string, "traefik")                         # Chart name to be installed<br>    chart_version = optional(string, "20.8.0")                          # Specify the exact chart version to install<br>    extra_values  = optional(list(string), [])                          # List of extra values in raw yaml to pass to helm<br>    name          = optional(string, "traefik")                         # Release name<br>    repository    = optional(string, "https://helm.traefik.io/traefik") # Repository URL where to locate the requested chart<br>    timeout       = optional(number, 900)                               # Time in seconds to wait for any individual kubernetes operation<br>  })</pre> | `{}` | no |
| <a name="input_ingress_routes"></a> [ingress\_routes](#input\_ingress\_routes) | Map of ingress routes | <pre>map(object({<br>    match = object({<br>      hosts         = list(string)<br>      paths         = optional(list(string), [])<br>      path_prefixes = optional(list(string), [])<br>    })<br>    namespace   = string<br>    middlewares = optional(list(string), [])<br>    priority    = optional(number)<br>    redirects = optional(object({<br>      from_non_www_to_www = optional(bool, false)<br>      from_www_to_non_www = optional(bool, false)<br>      regex = optional(map(object({<br>        permanent   = optional(bool, false)<br>        regex       = string<br>        replacement = string<br>      })), {})<br>    }), {})<br>    service = object({<br>      name   = string<br>      port   = number<br>      sticky = optional(bool, false)<br>    })<br>    tls = object({<br>      secret_name = string<br>    })<br>  }))</pre> | `{}` | no |
| <a name="input_ingress_routes_basic_auth"></a> [ingress\_routes\_basic\_auth](#input\_ingress\_routes\_basic\_auth) | Map of ingress routes Basic Authentication | <pre>map(object({<br>    password = string<br>    username = string<br>  }))</pre> | `{}` | no |
| <a name="input_ingress_routes_tcp"></a> [ingress\_routes\_tcp](#input\_ingress\_routes\_tcp) | Map of ingress routes TCP | <pre>map(object({<br>    entry_point = object({<br>      name = string<br>      port = number<br>    })<br>    namespace = string<br>    proxy_protocol = optional(object({<br>      enabled = optional(bool, false)<br>      version = optional(number, 2)<br>    }))<br>    service = object({<br>      name = string<br>      port = number<br>    })<br>    tls = optional(object({<br>      enabled     = optional(bool, false)<br>      secret_name = string<br>    }))<br>  }))</pre> | `{}` | no |
| <a name="input_kubernetes_providers"></a> [kubernetes\_providers](#input\_kubernetes\_providers) | Traefik provides configuration | <pre>object({<br>    crd = optional(object({<br>      enabled                      = optional(bool, true)  # Load Kubernetes IngressRoute provider<br>      allow_cross_namespace        = optional(bool, false) # Allows IngressRoute to reference resources in namespace other than theirs<br>      allow_external_name_services = optional(bool, false) # Allows to reference ExternalName services in IngressRoute<br>      allow_empty_services         = optional(bool, false) # Allows to return 503 when there is no endpoints available<br>    })),<br>    ingress = optional(object({<br>      enabled                      = optional(bool, true)  # Load Kubernetes IngressRoute provider<br>      allow_external_name_services = optional(bool, false) # Allows to reference ExternalName services in Ingress<br>      allow_empty_services         = optional(bool, false) # Allows to return 503 when there is no endpoints available<br>    }))<br>  })</pre> | `{}` | no |
| <a name="input_logs"></a> [logs](#input\_logs) | Traefik logs configuration | <pre>object({<br>    access = optional(object({<br>      enabled = optional(bool, false)<br>      fields = optional(object({<br>        general = optional(object({<br>          defaultmode = optional(string, "keep")  # Available modes: keep, drop, redact<br>          names       = optional(map(string), {}) # Names of the fields to limit. Example: { ClientUsername = "drop" }<br>        }), {})<br>        headers = optional(object({<br>          defaultmode = optional(string, "drop")  # Available modes: keep, drop, redact<br>          names       = optional(map(string), {}) # Names of the fields to limit. Example: { User-Agent = "redact" }<br>        }), {})<br>      }), {})<br>    }), {})<br>    general = optional(object({<br>      level = optional(string, "ERROR") # Logging levels. Alternative logging levels are DEBUG, PANIC, FATAL, ERROR, WARN, and INFO.<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_metrics"></a> [metrics](#input\_metrics) | Traefik metrics configuration | <pre>object({<br>    prometheus = optional(object({<br>      enabled     = optional(bool, true)<br>      entry_point = optional(string, "metrics") # Entry point used to expose metrics<br>      service = optional(object({<br>        enabled = optional(bool, false) # Create a dedicated metrics service for use with ServiceMonitor<br>      }), {})<br>      service_monitor = optional(object({<br>        enabled = optional(bool, false)<br>      }), {})<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_namespace"></a> [namespace](#input\_namespace) | Traefik namespace configuration | <pre>object({<br>    create = optional(bool, true)        # Create the namespace if it does not yet exist<br>    name   = optional(string, "traefik") # The namespace to install the release into<br>  })</pre> | `{}` | no |
| <a name="input_network_policies"></a> [network\_policies](#input\_network\_policies) | Traefik network policies configuration | <pre>object({<br>    egress = optional(object({<br>      allow = optional(object({<br>        within_namespace = optional(bool, false) # Allow egress traffic within the namespace<br>      }), {})<br>      default = optional(object({<br>        allow_all = optional(bool, false) # By default, allow all egress traffic<br>        deny_all  = optional(bool, false) # By default, deny all egress traffic<br>      }), {})<br>    }), {})<br>    ingress = optional(object({<br>      allow = optional(object({<br>        external = optional(object({<br>          enabled    = optional(bool, true)                  # Allowing external ingress<br>          from_cidrs = optional(list(string), ["0.0.0.0/0"]) # From these CIDRs<br>        }), {})<br>        monitoring_namespace = optional(bool, false) # Allow ingress traffic from the namespace named monitoring<br>        within_namespace     = optional(bool, false) # Allow ingress traffic within the namespace<br>      }), {})<br>      default = optional(object({<br>        allow_all = optional(bool, false) # By default, allow all ingress traffic<br>        deny_all  = optional(bool, false) # By default, deny all ingress traffic<br>      }), {})<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_ports"></a> [ports](#input\_ports) | Traefik ports configuration | <pre>object({<br>    lb_ip                     = optional(string, "") # The IP address of the kubernetes provider's LoadBalancer<br>    http_to_https_redirection = optional(bool, true) # Permanent redirect from HTTP to HTTPs<br>  })</pre> | `{}` | no |
| <a name="input_security_headers"></a> [security\_headers](#input\_security\_headers) | Traefik security headers configuration | <pre>object({<br>    frame_deny           = optional(bool, false)<br>    browser_xss_filter   = optional(bool, true)<br>    content_type_nosniff = optional(bool, true)<br>    sts = optional(object({<br>      include_subdomains = optional(bool, true)<br>      seconds            = optional(number, 315360000)<br>      preload            = optional(bool, true)<br>    }), {})<br>  })</pre> | `{}` | no |
| <a name="input_service"></a> [service](#input\_service) | Traefik service configuration | <pre>object({<br>    annotations      = optional(map(string), {}) # Additional annotations applied to both TCP and UDP services<br>    ip_family_policy = optional(string)          # One of SingleStack, PreferDualStack, or RequireDualStack<br>  })</pre> | `{}` | no |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_namespace"></a> [namespace](#output\_namespace) | Traefik namespace |
| <a name="output_version"></a> [version](#output\_version) | Traefik version |
<!-- END_TF_DOCS -->
