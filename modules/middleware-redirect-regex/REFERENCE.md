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

No providers.

## Modules

| Name | Source | Version |
|------|--------|---------|
| <a name="module_redirect_regex_middleware"></a> [redirect\_regex\_middleware](#module\_redirect\_regex\_middleware) | ../middleware | n/a |

## Resources

No resources.

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_metadata"></a> [metadata](#input\_metadata) | Traefik middleware Redirect Regex metadata | <pre>object({<br>    name      = string<br>    namespace = optional(string, "default")<br>  })</pre> | n/a | yes |
| <a name="input_permanent"></a> [permanent](#input\_permanent) | Set the permanent option to true to apply a permanent redirection | `bool` | `false` | no |
| <a name="input_regex"></a> [regex](#input\_regex) | The regular expression to match and capture elements from the request URL | `string` | n/a | yes |
| <a name="input_replacement"></a> [replacement](#input\_replacement) | How to modify the URL to have the new target URL | `string` | n/a | yes |

## Outputs

No outputs.
<!-- END_TF_DOCS -->