# Mosquitto

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Authentication setup](#authentication-setup)
- [Useful links](#useful-links)

## About

Mosquitto is an open source implementation of a server for version 5.0, 3.1.1,
and 3.1 of the MQTT protocol. It also includes a C and C++ client library, and
the mosquitto_pub and mosquitto_sub utilities for publishing and subscribing.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Authentication setup

It's recommendable to generate a password file, so unauthorised clients cannot
connect:

    docker exec -it mosquitto mosquitto_passwd -c /mosquitto/password_file <USER>

Update the `mosquitto.conf` file:

```conf
password_file /mosquitto/password_file
```

And restart Mosquitto.

## Useful links

- [Mosquitto](https://github.com/eclipse/mosquitto)
- [Authentication methods](https://mosquitto.org/documentation/authentication-methods/)
- [Deploying Mosquitto MQTT broker](https://techsparx.com/software-development/mqtt/mosquitto-docker.html)
