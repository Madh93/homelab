# Karakeepbot

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

[Karakeepbot](https://github.com/Madh93/karakeepbot) is a simple [Telegram Bot](https://core.telegram.org/bots) written in [Go](https://go.dev/) that enables users to effortlessly save bookmarks to [Karakeep](https://karakeep.app) (previously Hoarder), a self-hostable bookmark-everything app, directly through Telegram.

## Requirements

- [Telegram bot token](https://core.telegram.org/bots/features#botfather) (you can get one by talking to [@BotFather](https://t.me/BotFather) on Telegram)
- [Karakeep API Key](https://docs.karakeep.app/screenshots#settings)

## Configuration

### Docker setup

We create a `.env` file:

```shell
DEFAULT_NETWORK="badassnet"
KARAKEEPBOT_KARAKEEP_URL="http://karakeep:3000"
KARAKEEPBOT_KARAKEEP_TOKEN="supersecret"
KARAKEEPBOT_TELEGRAM_TOKEN="supersecret"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Karakeepbot](https://github.com/Madh93/karakeepbot)
