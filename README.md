# Traefik Terraform module

<!-- markdownlint-disable-next-line MD001 -->
#### Table of Contents

1. [Description](#description)
2. [Usage](#usage)
3. [Reference](#reference)
4. [Development](#development)
5. [Contributors](#contributors)

## Description

[Terraform](https://www.terraform.io/) module that allows you to deploy and configure [Træfik](https://traefik.io/traefik/)
on [Kubernetes](https://kubernetes.io/) via [Helm](https://helm.sh/).

## Usage

```terraform
module "traefik" {
  source  = "solution-libre/traefik/helm"

  ingress = {
    website = {
      match = {
        hosts = ["domain.tld"]
      }
      namespace    = "default"
      service = {
        name = "website"
        port = 80
      }
      tls = {
        secret_name = "domain.tld"
      }
    }
  }
}
```

## Reference

See [REFERENCE.md](./REFERENCE.md).

## Development

[Solution Libre](https://www.solution-libre.fr)'s repositories are open projects,
and community contributions are essential for keeping them great.

[Fork this repo on our GitLab](https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/forks/new).

## Contributors

The list of contributors can be found at: <https://usine.solution-libre.fr/french-high-availability-multi-cloud-hosting/terraform-modules/traefik/-/graphs/main>.
