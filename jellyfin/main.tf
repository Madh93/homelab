terraform {
  required_version = "~> 1.2"

  required_providers {
    cloudflare = {
      source  = "cloudflare/cloudflare"
      version = "3.19.0"
    }
  }
}

variable "cloudflare_token" {}
variable "domain_name" {}
variable "record_name" {}
variable "record_value" {}

provider "cloudflare" {
  api_token = var.cloudflare_token
}

data "cloudflare_zone" "default" {
  name = var.domain_name
}

resource "cloudflare_record" "default" {
  zone_id = data.cloudflare_zone.default.id
  type    = "CNAME"
  name    = var.record_name
  value   = var.record_value
  proxied = false # Bad performance when DNS Proxied is enabled
}
