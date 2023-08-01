module "generic" {
  source  = "solution-libre/generic/helm"
  version = "0.4.1"

  helm_release     = var.helm_release
  namespace        = var.namespace
  network_policies = var.network_policies

  values = templatefile(
    "${path.module}/templates/values.yaml.tpl",
    {
      deployment         = var.deployment
      ingress_routes_tcp = var.ingress_routes_tcp
      ports              = var.ports
      name               = var.helm_release.name
      namespace          = var.namespace.name
      service            = var.service
      providers          = var.providers
    }
  )
}
