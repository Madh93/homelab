# Calibre

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Calibre is the best software that exists to manage our e-books. By default, it
offers a web version, however it is not as beautiful as Calibre-Web offers,
which has an modern interface to browse, read and download our books using an
existing database. 

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="calibre.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Calibre](https://calibre-ebook.com)
- [Calibre Web](https://github.com/janeczku/calibre-web)
