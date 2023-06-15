resource "kubernetes_manifest" "ingress_routes_tcp" {
  for_each = var.ingress_routes_tcp

  manifest = yamldecode(templatefile(
    "${path.module}/templates/manifests/ingress-route-tcp.yaml.tpl",
    {
      entry_point    = each.value.entry_point
      name           = each.key
      namespace      = each.value.namespace
      proxy_protocol = each.value.proxy_protocol
      service        = each.value.service
    }
  ))

  depends_on = [
    module.generic
  ]
}
