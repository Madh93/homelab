terraform {
  required_version = "~> 1.0"

  required_providers {
    digitalocean = {
      source  = "digitalocean/digitalocean"
      version = "2.17.0"
    }
  }
}

variable "do_token" {}
variable "domain_name" {}
variable "record_name" {}
variable "record_value" {}

provider "digitalocean" {
  token = var.do_token
}

data "digitalocean_domain" "default" {
  name = var.domain_name
}

resource "digitalocean_record" "default" {
  domain = data.digitalocean_domain.default.name
  type   = "CNAME"
  name   = var.record_name
  value  = var.record_value
  ttl    = "43200"
}
