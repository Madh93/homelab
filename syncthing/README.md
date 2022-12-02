# Syncthing

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Syncthing is a continuous file synchronization program. It synchronizes files
between two or more computers in real time, safely protected from prying eyes.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
SYNC_DATA="/sync"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="syncthing.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Syncthing](https://syncthing.net/)
- [Syncthing by LinuxServer.io](https://docs.linuxserver.io/images/docker-syncthing)
