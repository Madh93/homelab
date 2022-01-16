# Portainer

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Portainer is a self-service container service that includes a GUI to manage and
visualise our Docker containers, images, volumes and networks.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="portainer.domain.tld"
```

And deploy:

    docker-compose up -d

## Useful links

- [Portainer](https://www.portainer.io/)
- [Portainer Compose Example](https://github.com/portainer/portainer-compose)
