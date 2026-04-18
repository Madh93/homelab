# Seerr

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Seerr is a free and open source software application for managing requests for your media library. It integrates with the media server of your choice: Jellyfin, Plex, and Emby. In addition, it integrates with your existing services, such as Sonarr, Radarr.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="seerr"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Seerr](https://github.com/seerr-team/seerr)
