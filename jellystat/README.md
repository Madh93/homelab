# Jellystat

- [About](#about)
- [Configuration](#configuration)
  * [JWT setup](#jwt-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Jellystat is a free and open source Statistics App for Jellyfin.

## Configuration

### JWT setup

Before running Jellystat it's necessary to define a JWT secret that will must be populated in the `.env` file as `JWT_SECRET` environment variable:

    openssl rand -base64 128

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="jellystat"
POSTGRES_PASSWORD="supersecret"
JWT_SECRET="supersecret"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Jellystat](https://github.com/CyferShepard/Jellystat)
- [Jellystat Docker Hub](https://hub.docker.com/r/cyfershepard/jellystat)
