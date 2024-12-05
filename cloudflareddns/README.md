# Cloudflare DDNS

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Cloudflare API Token creation](#cloudflare-api-token-creation)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

We usually have a dynamic IP address at home. This means that in any moment our
public IP can change, either by restarting the router, or simply because the ISP
feels like it. To access our home network from anywhere we need to have a
mechanism that allows us to avoid having to constantly update our IP address.

DDNS (Dynamic DNS) is the solution to this problem: it allows us to send
information of our current public IP, and have a DNS record that is always
pointing to this IP.

The DDNS service that we are going to use is Cloudflare DDNS,A a feature-rich
and robust Cloudflare DDNS updater with a small footprint. The program will
detect your machine’s public IP addresses and update DNS records using the
Cloudflare API.

## Requirements

- [Cloudflare account](https://www.cloudflare.com/)

## Configuration

### Cloudflare API Token creation

We only need to create an [API Token](https://developers.cloudflare.com/api/tokens/create/)

### Docker setup

We create a `.env` file:

```shell
DEFAULT_NETWORK="badassnet"
PUID=1000
PGID=1000
PROXIED_DOMAINS="domain.tld"
NOT_PROXIED_DOMAINS="other.tld"
CLOUDFLARE_API_TOKEN="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Cloudflare DDNS](https://github.com/favonia/cloudflare-ddns)
- [Cloudflare](https://www.cloudflare.com/)
- [Creating Cloudflare API tokens](https://developers.cloudflare.com/api/tokens/create/)

