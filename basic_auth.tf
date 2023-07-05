resource "kubernetes_secret" "basic_auth" {
  for_each = var.ingress_routes

  metadata {
    name      = "${each.key}-basic-auth"
    namespace = each.value.namespace
  }

  data = {
    username = each.value.auth.username
    password = each.value.auth.password
  }

  type = "kubernetes.io/basic-auth"
}
