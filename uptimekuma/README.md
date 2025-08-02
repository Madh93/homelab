# Uptime Kuma

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Uptime Kuma is a self-hosted monitoring tool like "Uptime Robot".

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="uptimekuma"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Uptime Kuma](https://uptime.kuma.pet/)
