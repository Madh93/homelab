# Hoarderbot

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Hoarderbot is a simple Telegram Bot written in Go that enables users to effortlessly save bookmarks to Hoarder, a self-hostable bookmark-everything app, directly through Telegram.

## Requirements

- [Telegram bot token](https://core.telegram.org/bots/features#botfather) (you can get one by talking to [@BotFather](https://t.me/BotFather) on Telegram)
- [Hoarder API Key](https://docs.hoarder.app/screenshots#settings)

## Configuration

### Docker setup

We create a `.env` file:

```shell
DEFAULT_NETWORK="badassnet"
HOARDERBOT_HOARDER_URL="http://hoarder:3000"
HOARDERBOT_HOARDER_TOKEN="supersecret"
HOARDERBOT_TELEGRAM_TOKEN="supersecret"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Hoarderbot](https://github.com/Madh93/hoarderbot)
