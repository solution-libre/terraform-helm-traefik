<!-- BEGIN_TF_DOCS -->
<!-- DO NOT EDIT: This document was generated by terraform-docs -->

# Reference

<!-- markdownlint-disable MD033 MD013 -->

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

No modules.

## Resources

| Name | Type |
|------|------|
| [kubernetes_manifest.this](https://registry.terraform.io/providers/hashicorp/kubernetes/latest/docs/resources/manifest) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Traefik ingress route metadata | <pre>object({<br>    annotations = optional(map(string), {})<br>    name        = string<br>    namespace   = optional(string, "default")<br>  })</pre> | n/a | yes |
| <a name="input_spec"></a> [spec](#input\_spec) | Traefik ingress route specifications | <pre>object({<br>    entry_points = optional(list(string), ["websecure"])<br>    routes = object({<br>      match = object({<br>        hosts         = list(string)<br>        paths         = optional(list(string), [])<br>        path_prefixes = optional(list(string), [])<br>      })<br>      middlewares = optional(list(string), [])<br>      priority    = optional(number)<br>      service = object({<br>        name   = string<br>        port   = number<br>        sticky = optional(bool, false)<br>      })<br>    })<br>    tls = object({<br>      secret_name = string<br>    })<br>  })</pre> | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->