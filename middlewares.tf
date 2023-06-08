resource "kubernetes_manifest" "default_middleware" {
  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/default.yaml.tpl",
    {
      name             = var.helm_release.name
      namespace        = module.generic.namespace
      security_headers = var.security_headers
    }
  ))

  depends_on = [
    module.generic
  ]
}

locals {
  from_non_www_to_www_redirects = { for value in var.ingress :
    value.namespace => value.redirect.from_non_www_to_www...
  }
  from_www_to_non_www_redirects = { for value in var.ingress :
    value.namespace => value.redirect.from_www_to_non_www...
  }
}

resource "kubernetes_manifest" "from_non_www_to_www_redirects_middleware" {
  for_each = toset([for namespace, values in local.from_non_www_to_www_redirects : namespace if anytrue(values)])

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/from-non-www-to-www-redirect.yaml.tpl",
    {
      namespace = each.value
    }
  ))

  depends_on = [
    module.generic
  ]
}

resource "kubernetes_manifest" "from_www_to_non_www_redirects_middleware" {
  for_each = toset([for namespace, values in local.from_www_to_non_www_redirects : namespace if anytrue(values)])

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/middlewares/from-www-to-non-www-redirect.yaml.tpl",
    {
      namespace = each.value
    }
  ))

  depends_on = [
    module.generic
  ]
}
