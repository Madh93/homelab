# Syncthing

- [About](#about)
- [Configuration](#configuration)
  * [Inotify limit](#inotify-limit)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Syncthing is a continuous file synchronization program. It synchronizes files
between two or more computers in real time, safely protected from prying eyes.

## Configuration

### Inotify limit

To avoid the the following error with the filesystem watcher:

    Failed to start filesystem watcher for folder yourLabel (yourID): failed to setup inotify handler. Please increase inotify limits, see https://docs.syncthing.net/users/faq.html#inotify-limits

It's necessary to increase the amount of watches per user (usually 8192) before
running Syncthing. To adjust the limit immediately, just run:

    echo 204800 | sudo tee /proc/sys/fs/inotify/max_user_watches

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
SYNC_DATA="/sync"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="syncthing"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Syncthing](https://syncthing.net/)
- [Syncthing by LinuxServer.io](https://docs.linuxserver.io/images/docker-syncthing)
- [Syncthing inotify limit](https://docs.syncthing.net/users/faq.html#inotify-limits)
