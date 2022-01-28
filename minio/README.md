# MinIO

- [About](#about)
- [Configuration](#configuration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

MinIO is a High Performance Object Storage. It is API compatible with Amazon S3
cloud storage service and it is the perfect self-hosted solution to store our
backups using other tools like Restic or Kopia.

## Configuration

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
API_DOMAIN_NAME="minio-api.domain.tld"
CONSOLE_DOMAIN_NAME="minio-console.domain.tld"
MINIO_ROOT_USER="superuser"
MINIO_ROOT_PASSWORD="supersecret"
PUID=1000
PGID=1000
```

And deploy:

    docker-compose up -d

## Useful links

- [MinIO](https://min.io/)
- [MinIO Docker Quickstart Guide](https://docs.min.io/docs/minio-docker-quickstart-guide.html)
- [Setting up MinIO with Docker Compose](https://linuxblog.xyz/posts/minio/)
