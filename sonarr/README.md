# Sonarr

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Sonarr is a PVR for Usenet and BitTorrent users. It can monitor multiple RSS
feeds for new episodes of your favorite shows and will grab, sort and rename
them. It can also be configured to automatically upgrade the quality of files
already downloaded when a better quality format becomes available.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
TV_SHOWS_DATA="/media/tvshows"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="sonarr.domain.tld"
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
    - domain: sonarr.domain.tld
      policy: bypass
      resources:
        - '^/api.*$'
```

## Useful links

- [Sonarr](https://sonarr.tv)
- [Sonarr source code](https://github.com/Sonarr/Sonarr)
- [Linuxserver Sonarr Docs](https://docs.linuxserver.io/images/docker-sonarr)
