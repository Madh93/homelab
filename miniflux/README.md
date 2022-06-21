# Miniflux

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

Miniflux is a minimalist and opinionated feed reader.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="miniflux.domain.tld"
POSTGRES_DATABASE="miniflux"
POSTGRES_USER="miniflux"
POSTGRES_PASSWORD="supersecret"
MINIFLUX_USER="superuser"
MINIFLUX_PASSWORD="supersecret"
```

And deploy:

    docker-compose up -d

### Authelia setup

Add the next environment variables in the Docker Compose file:

```yml
services:
  # ...
  miniflux:
    # ...
    environment:
      - AUTH_PROXY_USER_CREATION=1
      - AUTH_PROXY_HEADER=Remote-User
```

NOTE: The [current implementation](https://github.com/miniflux/v2/pull/570) only support the `/` endpoint, as the rest are protected by Miniflux.

#### Fever support

It's necessary to bypass `/fever`.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: miniflux.domain.tld
      policy: bypass
      resources:
        - "^/fever.*"
```

## Useful links

- [Miniflux](https://miniflux.app/)
- [Miniflux Docker Compose examples](https://github.com/miniflux/v2/tree/master/contrib/docker-compose)
