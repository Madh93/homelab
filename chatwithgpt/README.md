# Chat with GPT

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Chat with GPT is an open-source, unofficial ChatGPT app with extra features and
more ways to customize your experience. It connects ChatGPT with ElevenLabs to
give ChatGPT a realistic human voice.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="chatwithgpt.domain.tld"
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Chat with GPT](https://github.com/cogentapps/chat-with-gpt)
