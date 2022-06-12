# Calibre

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
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

### Authelia setup

Go to `Admin` -> `Basic Configuration` -> `Feature Configuration`:

1. Enable `Allow Reverse Proxy Authentication`
2. Add `Remote-User` as `Reverse Proxy Header Name`

More info [here](https://github.com/janeczku/calibre-web/wiki/Setup-Reverse-Proxy#traefik--241-with-authelia-forward-auth).

#### OPDS support

It's necessary to bypass `/opds`.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: calibre.domain.tld
      policy: bypass
      resources:
        - "^/opds.*"
```

An [issue](https://github.com/janeczku/calibre-web/issues/2399) about this problem already exists.

## Useful links

- [Calibre](https://calibre-ebook.com)
- [Calibre Web](https://github.com/janeczku/calibre-web)
- [Setup Traefik with Authelia Forward Auth](https://github.com/janeczku/calibre-web/wiki/Setup-Reverse-Proxy#traefik--241-with-authelia-forward-auth)
