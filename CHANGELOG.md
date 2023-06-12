# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-configure-file { "MD024": { "allow_different_nesting": true } } -->

## [0.8.1] 2023-06-08

### Fixed

- Bad `regex` and `replacement` syntax for `from-non-www-to-www-redirect` middleware

## [0.8.0] 2023-06-08

### Added

- Optionnal redirection from non-www to www
- Recommanded VSCode extentions
- Some VSCode tasks

### Changed

- `www_redirect` attribut in `ingress` input variable now named `redirect` and its a map with two exclusive boolean
attribute `from_non_www_to_www` and `from_www_to_non_www`
- Use whitespace stripping in template
- `service.annotations` is a map of strings instead of string

## [0.7.0] 2023-05-30

### Added

- An input variables `deployment` to configure Deployment or DaemonSet and the number of replicas
- An input variable `lb_ip` to add the IP address of the kubernetes provider's LoadBalancer to the list of trusted IPs

### Changed

- Refacto
- Use whitespace stripping in template
- Dedicated input variables `service` instead of part of `helm_release`
- Rename `app_version` output variable to `version`

## [0.6.0] 2023-01-19

### Added

- Output `namespace`
- Output `app_version`
- Possibility to use user defined middlewares
- Add CORS middlewares

### Changed

- Use of the generic module from the registry
- Upgrade of the generic module to v0.4.1

## [0.5.0] 2022-12-15

### Added

- Input variables to manage secure headers

### Changed

- Upgrade of the generic module to v0.4.0

## [0.4.2] 2022-12-07

### Added

- Secure TLS options by default
- Secure headers by default

## [0.4.1] 2022-12-07

### Changed

- Added IP addresses block for carrier-grade NAT deployment in trusted IPs of proxy-protocol

## [0.4.0] 2022-11-30

### Changed

- Allow all cluster to call Traefik

### Removed

- The optionnal Network Policy to allow cert-manager

## [0.3.0] 2022-11-18

### Added

- Input variables to enable each Network Policy one by one

### Changed

- Upgrade of the generic module to v0.2.0
- Use `kubernetes.io/metadata.name` label instead of `name` to match namespace in Network Policies

### Removed

- Input variable `labels_prefix`

## [0.2.1] 2022-11-18

### Added

- An optionnal Network Policy to allow cert-manager

### Change

- Reduce priority of HTTP to HTTps redirection to work with cert-manager

## [0.2.0] 2022-11-17

### Added

- A map of ingress to add Ingress Routes

## [0.1.2] 2022-11-10

### Fixed

- Network policies

## [0.1.1] 2022-11-09

### Fixed

- Missing interpretation of the values in the Helm chart

## [0.1.0] 2022-11-01

### Added

- Terraform module creation

[0.8.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.8.0...v0.8.1
[0.8.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.7.0...v0.8.0
[0.7.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.6.0...v0.7.0
[0.6.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.5.0...v0.6.0
[0.5.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.4.2...v0.5.0
[0.4.2]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.4.1...v0.4.2
[0.4.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.4.0...v0.4.1
[0.4.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.3.0...v0.4.0
[0.3.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.2.1...v0.3.0
[0.2.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.2.0...v0.2.1
[0.2.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.1.2...v0.2.0
[0.1.2]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.1.1...v0.1.2
[0.1.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.1.0...v0.1.1
[0.1.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/tags/v0.1.0
