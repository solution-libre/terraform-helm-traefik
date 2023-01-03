# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/),
and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

<!-- markdownlint-configure-file { "MD024": { "allow_different_nesting": true } } -->

## [Unreleased]

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

[Unreleased]: https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/compare/v0.5.0...HEAD
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
