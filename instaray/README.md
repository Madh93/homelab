# Instaray

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Instaray is a simple [Telegram Bot](https://core.telegram.org/bots) written in [Go](https://go.dev/) that fixes Twitter, Instagram and TikTok embeds in Telegram using [FxTwitter](https://github.com/FixTweet/FxTwitter), [InstaFix](https://github.com/Wikidepia/InstaFix) and [vxtiktok](https://github.com/dylanpdx/vxtiktok).

## Requirements

- [Telegram bot token](https://core.telegram.org/bots/features#botfather) (you can get one by talking to [@BotFather](https://t.me/BotFather) on Telegram)

## Configuration

### Docker setup

We create a `.env` file:

```shell
DEFAULT_NETWORK="badassnet"
INSTARAY_TELEGRAM_TOKEN="supersecret"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Instaray](https://github.com/Madh93/instaray)
