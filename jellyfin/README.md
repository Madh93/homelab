# Jellyfin

- [About](#about)
- [Requirements](#requirements)
- [Configuration](#configuration)
  * [Hardware acceleration](#hardware-acceleration)
  * [Docker setup](#docker-setup)
- [Useful links](#useful-links)

## About

Jellyfin is a media solution that puts you in control of your media: movies, TV
shows, music, live TV. Jellyfin lets you watch your media from a web browser on
your computer, apps on your Roku, Android, iOS (including AirPlay), Android TV,
or Fire TV device, or via your Chromecast or existing Kodi.

## Requirements

- [Hardware acceleration (optional)](https://jellyfin.org/docs/general/administration/hardware-acceleration.html)

## Configuration

### Hardware acceleration

Jellyfin supports hardware acceleration of video encoding/decoding using FFMpeg.
FFMpeg and Jellyfin can support multiple hardware acceleration implementations
such as Intel Quicksync (QSV), AMD AMF, nVidia NVENC/NVDEC, OpenMax OMX and
MediaCodec through Video Acceleration API's. To enable hardware acceleration:

```yml
  privileged: true
  devices:
    - /dev/dri:/dev/dri
```

This configuration depends on the hardware where Jellyfin runs. In this case it
is assumed it is using Intel Quicksync.

### Docker setup

We create a `.env` file:

```shell
DOCKER_DATA="/docker/data"
DEFAULT_NETWORK="badassnet"
DOMAIN_NAME="jellyfin.domain.tld"
PUID=1000
PGID=1000
TZ="Europe/Madrid"
```

And deploy:

    docker-compose up -d

## Useful links

- [Jellyfin](https://jellyfin.org/)
- [Jellyfin Hardware Acceleration](https://jellyfin.org/docs/general/administration/hardware-acceleration.html)
- [Jellyfin Media Organization](https://jellyfin.org/docs/general/server/media/movies.html)
- [Linuxserver Jellyfin Docs](https://docs.linuxserver.io/images/docker-jellyfin)
- [Installing Jellyfin on LG webOS](https://dev.to/kylejschwartz/installing-jellyfin-on-lg-webos-2d7b)
