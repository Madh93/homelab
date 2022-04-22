# SABnzbd

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

SABnzbd is an Open Source Binary Newsreader written in Python.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
INCOMPLETE_DOWNLOADS_DATA="/incomplete"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="sabnzbd.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [SABnzbd](https://sabnzbd.org/)
- [Linuxserver SABnzbd Docs](https://docs.linuxserver.io/images/docker-sabnzbd)
