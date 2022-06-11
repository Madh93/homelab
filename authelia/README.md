# Authelia

- [About](#about)
- [Configuration](#configuration)
  * [Config files](#config-files)
  * [Secrets setup](#secrets-setup)
  * [Docker setup](#docker-setup)
  * [First login](#first-login)
  * [Add a service](#add-a-service)
- [Useful links](#useful-links)

## About

Authelia is an open-source authentication and authorization server providing
two-factor authentication and single sign-on (SSO) for your applications via a
web portal. It acts as a companion for reverse proxies like nginx, Traefik,
caddy or HAProxy to let them know whether requests should either be allowed or
redirected to Authelia's portal for authentication.

## Configuration

### Config files

Create a `configuration.yml` for Authelia settings and ensure to add your [custom root domain](https://www.authelia.com/docs/configuration/session/#domain) for session management:

    cp configuraction.yml.example configuration.yml

Create a `users.yml` for Authelia user management:

    cp users.yml.example users.yml

This file contains hashed passwords instead of plain text passwords. You can use
Authelia docker image to generate a [hashed password](https://www.authelia.com/docs/configuration/authentication/file.html#passwords):

    docker run --rm authelia/authelia authelia hash-password 'supersecret1234'

### Secrets setup

Before running Authelia for the first time we need to generate some secrets. We
start by creating the secrets directory:

    mkdir -p $DOCKER_DATA/authelia/config/secrets

Authelia supports multiple [storage backends](https://www.authelia.com/docs/configuration/storage/). The backend is used to store user
preferences, 2FA device handles and secrets, authentication logs, etc. An [encryption key](https://www.authelia.com/docs/configuration/storage/#encryption_key) is used to encrypt data in the database.

To generate the encryption key file:

    echo '<SUPER_SECRET>' > $DOCKER_DATA/authelia/config/secrets/encryption_key
    chmod 400 $DOCKER_DATA/authelia/config/secrets/encryption_key

Apart of that, it's necessary to define a [JWT secret](https://www.authelia.com/docs/configuration/miscellaneous.html#jwt_secret) for the identity verification process:

    echo '<SUPER_SECRET>' > $DOCKER_DATA/authelia/config/secrets/jwt
    chmod 400 $DOCKER_DATA/authelia/config/secrets/jwt

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="authelia.domain.tld"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### First login

Access to the Authelia login page and login with an existing user in `users.yml`
file. You need to register a 2FA device. A notification will be available in `$DOCKER_DATA/authelia/config/notifications.txt`.

### Add a service

To ensure Authelia is working correctly add the authelia middleware in your
service:

```yml
labels:
  - "traefik.http.routers.target_service.middlewares=authelia"
```

After recreating container you will be redirect to the Authelia login page.
Depending on the Authelia acces control rules you will get a forbidden or a
successful authentication. More info [here](https://www.authelia.com/docs/configuration/access-control.html).

## Useful links

- [Authelia](https://www.authelia.com/)
- [Authelia example with Traefix integration](https://www.authelia.com/docs/deployment/supported-proxies/traefik2.x.html)
- [Authelia configuration](https://www.authelia.com/docs/configuration/)
