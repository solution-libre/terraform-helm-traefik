resource "kubernetes_manifest" "ingress_routes" {
  for_each = var.ingress_routes

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/ingress-route.yaml.tpl",
    {
      name         = each.key
      namespace    = each.value.namespace
      middlewares  = each.value.middlewares
      hostname     = each.value.hostname
      service_name = each.value.service_name
      service_port = each.value.service_port
      redirect     = each.value.redirect
    }
  ))

  depends_on = [
    module.generic
  ]
}

moved {
  from = kubernetes_manifest.ingress_route
  to   = kubernetes_manifest.ingress_routes
}

resource "kubernetes_manifest" "tls_options" {
  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/tls-options.yaml.tpl",
    {
      name      = var.helm_release.name
      namespace = module.generic.namespace
    }
  ))
}
