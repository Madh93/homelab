# Open WebUI

- [About](#about)
- [Configuration](#configuration)
  * [Secret setup](#secret-setup)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Open WebUI is an extensible, feature-rich, and user-friendly self-hosted WebUI designed to operate entirely offline. It supports various LLM runners, including Ollama and OpenAI-compatible APIs.

## Configuration

### Secret setup

Before running Open WebUI it's necessary to define a [secret key](https://docs.openwebui.com/getting-started/env-configuration#webui_secret_key) that will must be populated in the `.env` file as `WEBUI_SECRET_KEY` environment variable:

    openssl rand -hex 64

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="domain.tld"
SUBDOMAIN="openwebui"
WEBUI_SECRET_KEY="supersecret"
OLLAMA_BASE_URL="http://localhost:11434"
```

And deploy:

    docker-compose up -d

## Useful links

- [Open WebUI](https://openwebui.com/)
