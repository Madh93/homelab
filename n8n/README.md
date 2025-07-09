# n8n

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

n8n is an open-source and fair-code workflow automation platform. It allows you to connect different applications and services with minimal code. Its visual node-based interface makes it easy to create complex automations, combining visual building with the ability to add custom JavaScript or Python code.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="n8n"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [n8n](https://n8n.io/)
