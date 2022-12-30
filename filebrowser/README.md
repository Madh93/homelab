# File Browser

- [About](#about)
- [Configuration](#configuration)
  * [Database setup](#database-setup)
  * [Docker setup](#docker-setup)
  * [Authelia setup](#authelia-setup)
- [Useful links](#useful-links)

## About

File Browser provides a file managing interface within a specified directory and
it can be used to upload, delete, preview, rename and edit your files. It allows
the creation of multiple users and each user can have its own directory. It can
be used as a standalone app.

## Configuration

### Database setup

We must create an empty database file to run File Browser for the first time:

    touch $DOCKER_DATA/filebrowser/filebrowser.db

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="filebrowser.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Authelia setup

It's necessary to bypass some resources for sharing files.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: filebrowser.domain.tld
      policy: bypass
      resources:
        - '^/api/public/dl.*$'
        - '^/api/public/share.*$'
        - '^/share.*$'
        - '^/static.*$'
```

## Useful links

- [File Browser](https://filebrowser.org/)
- [File Browser Config](https://filebrowser.org/cli/filebrowser)
- [File Browser Authentication](https://filebrowser.org/configuration/authentication-method)
