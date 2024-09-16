# Traefik Ingress Route Terraform module

<!-- markdownlint-disable-next-line MD001 -->
#### Table of Contents

1. [Description](#description)
2. [Usage](#usage)
3. [Reference](#reference)
4. [Development](#development)
5. [Contributors](#contributors)

## Description

[Terraform](https://www.terraform.io/) module that allows you to configure [Træfik](https://traefik.io/traefik/) Ingress
Route on [Kubernetes](https://kubernetes.io/) via [Helm](https://helm.sh/).

## Usage

```terraform
module "traefik_ingress_route" {
  source  = "solution-libre/traefik/helm//modules/ingress-route"

  metadata = {
    name = "website"
  }

  spec = {
    routes = {
      match = {
        hosts = ["domain.tld"]
      }
      service = {
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
