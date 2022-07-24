# Fail2ban

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Telegram notifications](#telegram-notifications)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Fail2Ban scans log files like `/var/log/auth.log` and bans IP addresses
conducting too many failed login attempts.

It does this by updating system firewall rules to reject new connections from
those IP addresses, for a configurable amount of time. Fail2Ban comes
out-of-the-box ready to read many standard log files, such as those for sshd and
Apache, and is easily configured to read any log file of your choosing, for any
error you wish.

## Requirements

- [Telegram Bot token (optional)](https://core.telegram.org/bots)

## Configuration

### Telegram notifications

First we need to talk to the
[BotFather](https://core.telegram.org/bots#6-botfather) and follow a few simple
steps to get an authentication token. Then we can create a channel or use our
personal chat ID to receive the notifications. After that it is just necessary
to configure the environment variables:

```yaml
environment:
  - TELEGRAM_AUTH_TOKEN=$TELEGRAM_AUTH_TOKEN
  - TELEGRAM_CHAT_ID=$TELEGRAM_CHAT_ID
```

Enable the custom action in the Fail2ban jail configuration:

```ini
[traefik-botsearch]
action = iptables-multiport[port="http,https",chain="FORWARD"] telegram-notifications
```

![Telegram notifications example](docs/img/fail2ban-telegram-notifications.png)

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
TZ="Europe/Madrid"
TELEGRAM_AUTH_TOKEN="superBotSecret"
TELEGRAM_CHAT_ID="myChatID"
```

And deploy:

    docker-compose up -d

## Useful links

- [Fail2ban](https://www.fail2ban.org/)
- [Fail2ban Traefik example](https://github.com/crazy-max/docker-fail2ban/tree/master/examples/jails/traefik)
- [Using Fail2ban with Traefik](https://geekland.eu/usar-fail2ban-con-traefik-para-proteger-servicios-que-corren-en-docker/)
- [Fail2ban Telegram notifications](https://github.com/deividgdt/fail2ban_telegram_notifications)
