# Radarr

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Radarr is a movie collection manager for Usenet and BitTorrent users. It can
monitor multiple RSS feeds for new movies and will interface with clients and
indexers to grab, sort, and rename them.

It can also be configured to automatically upgrade the quality of existing files
in the library when a better quality format becomes available. Note that only
one type of a given movie is supported

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
MOVIES_DATA="/media/movies"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="radarr.domain.tld"
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
    - domain: radarr.domain.tld
      policy: bypass
      resources:
        - '^/api.*$'
```

## Useful links

- [Radarr](https://radarr.video/)
- [Radarr source code](https://github.com/Radarr/Radarr)
- [Linuxserver Radarr Docs](https://docs.linuxserver.io/images/docker-radarr)
