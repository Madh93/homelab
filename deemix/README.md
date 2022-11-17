# deemix

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

deemix (lowercase) is a barebone deezer downloader library built from the ashes
of Deezloader Remix.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="deemix.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [deemix](https://deemix.app/)
- [deemix-docker](https://gitlab.com/Bockiii/deemix-docker)
