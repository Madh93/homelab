# Baikal

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Database setup](#database-setup)
- [Useful links](#useful-links)

## About

Baïkal is a lightweight CalDAV+CardDAV server. It offers an extensive web
interface with easy management of users, address books and calendars. Baïkal
allows to seamlessly access your contacts and calendars from every device.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="baikal.domain.tld"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Database setup

It's necessary to make sure the database directory exists:

    docker exec -itu nginx baikal mkdir /var/www/baikal/Specific/db

There is already an [issue](https://github.com/ckulka/baikal-docker/issues/86) about this problem.

## Useful links

- [Baïkal](https://sabre.io/baikal/)
- [Baïkal Docker](https://github.com/ckulka/baikal-docker)
