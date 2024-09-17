# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.1.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-configure-file { "MD024": { "siblings_only": true } } -->

## [0.17.1] 2024-09-17

### Fixed

- TLS section is not set in IngressRouteTCP

## [0.17.0] 2024-09-16

### Changed

- IngressRoute, IngressRouteTCP and Middlewares have their own sub-modules.
**You need to add some `moved` blocks to avoid recreations.**

## [0.16.0] 2024-01-26

### Added

- `middlewares` input variable
- StripPrefix middleware template

### Changed

- Renamed `middlewares` attribute of input variable `ingress_routes` to `custom_middlewares`
- Renamed `ingresss_routes_basic_auth` input variable to `middlewares_basic_auth`

## [0.15.3] 2024-01-25

### Added

- Validation in `deployement` input variable
- `access` map attribute in `logs` input variable

## [0.15.2] 2023-12-15

### Added

- forwardedHeaders.trustedIPs to web and websecure entrypoints

## [0.15.1] 2023-11-02

### Added

- Basic Auth middleware

## [0.15.0] 2023-10-06

### Added

- `regex` attribute of `redirects` attribute of input variable `ingress_routes` to manage RedirectRegex

### Changed

- Bump generic module version from 0.5.0 to 0.6.0
- Rename `redirect` attribute of input variable `ingress_routes` to `redirects`

## [0.14.0] 2023-10-05

### Added

- `priority`, `tls` and `match` attributes of `ingress_routes` input variable

### Changed

- It is now possible to define multiple hostnames and their associated paths and/or prefixed paths in `match` attribute of
`ingress_routes` input variable
- The TLS secret name is no longuer the hostname

### Removed

- `hostname` attribute of `ingress_routes` input variable

## [0.13.2] 2023-09-15

### Fixed

- Display the right service on Grafana instead of traefik-metrics

## [0.13.1] 2023-09-14

### Changed

- Bump generic module version from 0.4.1 to 0.5.0

## [0.13.0] 2023-09-14

### Added

- Input variable `metrics` to configure metrics
- Input variable `logs` to configure logs

### Changed

- Bump chart version from 17.0.5 to 20.8.0

## [0.12.0] 2023-08-02

### Added

- Input variable `kubernetes_providers` to configure providers

## [0.11.0] 2023-07-05

### Added

- Ability to disable HTTP to HTTPs permanent redirection
- Attributes of input variables documentation

### Changed

- Input variable `lb_ip` are now an attribute of `ports`

## [0.10.1] 2023-06-29

### Changed

- Attributes `entry_point`  of input variable `ingress_routes_tcp` are now a map

## [0.10.0] 2023-06-28

### Added

- Enable a sticky cookie for IngressRoute

### Changed

- Attributes `service_name` and `service_port` of input variable `ingress_routes` are now attribute of a map nammed `service`

## [0.9.1] 2023-06-28

### Added

- TLS secret name for IngressRouteTCP

## [0.9.0] 2023-06-15

### Added

- IngressRouteTCP

### Changed

- Rename input variable `ingress` to `ingress_routes`

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

[0.17.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.17.0...v0.17.1
[0.17.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.16.0...v0.17.0
[0.16.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.15.3...v0.16.0
[0.15.3]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.15.2...v0.15.3
[0.15.2]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.15.1...v0.15.2
[0.15.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.15.0...v0.15.1
[0.15.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.14.0...v0.15.0
[0.14.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.13.2...v0.14.0
[0.13.2]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.13.1...v0.13.2
[0.13.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.13.0...v0.13.1
[0.13.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.12.0...v0.13.0
[0.12.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.11.0...v0.12.0
[0.11.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.10.1...v0.11.0
[0.10.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.10.0...v0.10.1
[0.10.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.9.1...v0.10.0
[0.9.1]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.9.0...v0.9.1
[0.9.0]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.8.1...v0.9.0
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
