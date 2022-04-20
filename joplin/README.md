# Joplin

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Joplin is a free, open source note taking and to-do application, which can
handle a large number of notes organised into notebooks. The notes are
searchable, can be copied, tagged and modified either from the applications
directly or from your own text editor. The notes are in Markdown format.

Notes exported from Evernote can be imported into Joplin, including the
formatted content (which is converted to Markdown), resources (images,
attachments, etc.) and complete metadata (geolocation, updated time, created
time, etc.). Plain Markdown files can also be imported.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="joplin.domain.tld"
POSTGRES_DATABASE="joplin"
POSTGRES_USER="joplin"
POSTGRES_PASSWORD="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Joplin](https://joplinapp.org/)
- [How to run Joplin Server on Docker with Traefik and SSL](https://ae3.ch/joplin-server-on-docker-with-traefik-and-ssl)
