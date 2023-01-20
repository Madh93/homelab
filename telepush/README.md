# Telepush

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
  * [Webhook setup](#webhook-setup)
  * [Authelia setup](#authelia-setup)  
- [Useful links](#useful-links)

## About

A simple Telegram Bot to translate `POST` requests with `JSON` payload into Telegram
push messages. Similar Gotify and ntfy.sh, except without an extra app. Useful
for server monitoring, alerting, and anything else.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="telepush.domain.tld"
TELEGRAM_AUTH_TOKEN="superBotSecret"
URL_SECRET="randomString"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

### Webhook setup

Set the webhook accordingly the [docs](https://core.telegram.org/bots/api#setwebhook):

    curl -F "url=https://$DOMAIN_NAME/api/updates_$URL_SECRET" https://api.telegram.org/bot$TELEGRAM_AUTH_TOKEN/setWebhook

### Authelia setup

It's necessary to bypass some resources to accept Telegram messages.

Add the next rule to the Authelia `configuration.yml`:

```yml
access_control:
  default_policy: deny
  rules:
    - domain: telepush.domain.tld
      policy: bypass
      resources:
        - '^/api/updates_<URL_SECRET>.*$'
        - '^/api/messages/.*$'
```

## Useful links

- [Telepush](https://github.com/muety/telepush)
- [Telegram Webhooks](https://core.telegram.org/bots/webhooks)
- [Telegram setWebhook reference](https://core.telegram.org/bots/api#setwebhook)
