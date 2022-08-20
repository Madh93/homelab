# Bazarr

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Bazarr is a companion application to Sonarr and bazarr. It can manage and
download subtitles based on your requirements. You define your preferences by TV
show or movie and Bazarr takes care of everything for you.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
MOVIES_DATA="/media/movies"
TV_SHOWS_DATA="/media/tvshows"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="bazarr.domain.tld"
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
    - domain: bazarr.domain.tld
      policy: bypass
      resources:
        - '^/api.*$'
```

## Useful links

- [Bazarr](https://bazarr.media/)
- [Bazarr source code](https://github.com/morpheus65535/bazarr)
- [Linuxserver Bazarr Docs](https://docs.linuxserver.io/images/docker-bazarr)
