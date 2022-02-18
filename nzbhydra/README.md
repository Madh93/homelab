# NZBHydra 2

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

NZBHydra 2 is a meta search for newznab indexers and torznab trackers. It
provides easy access to newznab indexers and many torznab trackers via Jackett.
You can search all your indexers and trackers from one place and use it as an
indexer source for tools like Sonarr, Radarr, Lidarr or CouchPotato.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="nzbhydra.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [NZBHydra 2](https://github.com/theotherp/nzbhydra2)
- [Linuxserver NZBHydra 2 Docs](https://docs.linuxserver.io/images/docker-nzbhydra2)
