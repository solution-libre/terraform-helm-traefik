output "namespace" {
  description = "Traefik namespace"
  value       = module.generic.namespace
}

output "app_version" {
  description = "Traefik version"
  value       = module.generic.app_version
}
