# pyLoad

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

pyLoad is a free and open source download manager written in Python and designed
to be extremely lightweight, easily extensible and fully manageable via web.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="pyload.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [pyLoad](https://pyload.net)
