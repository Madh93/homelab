# BentoPDF

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

BentoPDF is a powerful, privacy-first, client-side PDF toolkit that is self
hostable and allows you to manipulate, edit, merge, and process PDF files
directly in your browser. No server-side processing is required, ensuring your
files remain secure and private.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="bentopdf"
PUID=1000
PGID=100
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [BentoPDF](https://www.bentopdf.com/)
