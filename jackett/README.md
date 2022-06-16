# Jackett

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Jackett is a BitTorrent indexer that works as a proxy server. It allows you to
add all of your favorite torrent indexing sites in one place without needing to
visit each site individually. On the other hand, it can also be integrated with
NZBHydra 2 as indexer.

To bypass Cloudflare protection it uses FlareSolverr as proxy server.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="jackett.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Authelia setup

It's necessary to bypass `/api` if you want to use a third party application as [nzb360](https://nzb360.com).

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: jackett.domain.tld
      policy: bypass
      resources:
        - '^/api.*$'
```    

## Useful links

- [Jackett](https://github.com/Jackett/Jackett)
- [Linuxserver Jackett Docs](https://docs.linuxserver.io/images/docker-jackett)
