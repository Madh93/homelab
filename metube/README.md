# MeTube

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

MeTube is a web GUI for youtube-dl (using the yt-dlp fork) with playlist
support. Allows you to download videos from YouTube and dozens of other sites,

## Configuration

### Authentication

MeTube does not have authentication by default. The current authentication is
powered by [Authelia](../authelia//README.md) using the `authelia` middlware.

Alternatively this can be solved with Traefik using the [BasicAuth middleware](https://doc.traefik.io/traefik/middlewares/http/basicauth/) generating a password file:

    mkdir -p $DOCKER_DATA/traefik/credentials
    htpasswd -c -b $DOCKER_DATA/traefik/credentials/metube <USERNAME> <PASSWORD>

And creating the middleware:

```yml
labels:
  # ...
  - "traefik.http.middlewares.metube-auth.basicauth.usersfile=/credentials/metube"
  - "traefik.http.routers.metube.middlewares=metube-auth"
```

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DOWNLOADS_DATA="/downloads"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="metube.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [MeTube](https://github.com/alexta69/metube)
