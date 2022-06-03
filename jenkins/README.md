# Jenkins

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Jenkins is a self-contained, open source automation server which can be used to
automate all sorts of tasks related to building, testing, and delivering or
deploying software.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="jenkins.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
JENKINS_WHITELIST="192.168.0.0/24"
```

And deploy:

    docker-compose up -d

## Useful links

- [Jenkins](https://www.jenkins.io)
