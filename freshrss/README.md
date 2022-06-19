# FreshRSS

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

FreshRSS is an RSS aggregator and reader. It allows you to read and follow
several news websites at a glance without the need to browse from one website to
another.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="freshrss.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [FreshRSS](https://freshrss.org/)
- [Linuxserver FreshRSS Docs](https://docs.linuxserver.io/images/docker-freshrss)
