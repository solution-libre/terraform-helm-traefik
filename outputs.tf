output "namespace" {
  description = "Traefik namespace"
  value       = module.generic.namespace
}

output "version" {
  description = "Traefik version"
  value       = module.generic.app_version
}
