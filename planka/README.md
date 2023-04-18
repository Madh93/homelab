# Planka

- [About](#about)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Planka is a flexible and customizable project management tool that helps teams collaborate and organize their tasks and projects.

## Configuration

### Secret setup

Before running Planka it's necessary to define a [secret key](https://docs.planka.cloud/docs/installl-planka/Docker%20Compose#docker-compose) that will must be populated in the `.env` file as `SECRET_KEY` environment variable:

    openssl rand -hex 64

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="planka.domain.tld"
POSTGRES_DATABASE="planka"
POSTGRES_USER="planka"
POSTGRES_PASSWORD="supersecret"
SECRET_KEY="supersecret"
```

And deploy:

    docker-compose up -d

## Useful links

- [Planka](https://planka.app/)
