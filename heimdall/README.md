# Heimdall

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Heimdall is an elegant dashboard to organise all your web applications. It
doesn't need to be limited to applications though, you can add links to anything
you like. It’s dedicated to this purpose so you won’t lose your links in a sea
of bookmarks.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="heimdall"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Heimdall](https://heimdall.site/)
- [Linuxserver Heimdall Docs](https://docs.linuxserver.io/images/docker-heimdall)
