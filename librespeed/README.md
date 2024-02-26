# LibreSpeed

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

This is a very lightweight speed test implemented in Javascript, using XMLHttpRequest and Web Workers.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="librespeed.domain.tld"
PASSWORD="supersecret"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [LibreSpeed](https://librespeed.org/)
- [LibreSpeed source code](https://github.com/librespeed/speedtest)
- [Linuxserver LibreSpeed Docs](https://docs.linuxserver.io/images/docker-librespeed)
