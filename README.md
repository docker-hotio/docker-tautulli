[<img src="https://hotio.dev/img/tautulli.png" alt="logo" height="130" width="130">](https://github.com/Tautulli/Tautulli)

[![GitHub Source](https://img.shields.io/badge/github-source-ffb64c?style=flat-square&logo=github&logoColor=white&labelColor=757575)](https://github.com/hotio/tautulli)
[![GitHub Registry](https://img.shields.io/badge/github-registry-ffb64c?style=flat-square&logo=github&logoColor=white&labelColor=757575)](https://github.com/orgs/hotio/packages/container/package/tautulli)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/tautulli?color=ffb64c&style=flat-square&label=pulls&logo=docker&logoColor=white&labelColor=757575)](https://hub.docker.com/r/hotio/tautulli)
[![Discord](https://img.shields.io/discord/610068305893523457?style=flat-square&color=ffb64c&label=discord&logo=discord&logoColor=white&labelColor=757575)](https://hotio.dev/discord)
[![Upstream](https://img.shields.io/badge/upstream-project-ffb64c?style=flat-square&labelColor=757575)](https://github.com/tautulli/tautulli)
[![Website](https://img.shields.io/badge/website-hotio.dev-ffb64c?style=flat-square&labelColor=757575)](https://hotio.dev/containers/tautulli)

## Starting the container

CLI:

```shell
docker run --rm \
    --name tautulli \
    -p 8181:8181 \
    -e PUID=1000 \
    -e PGID=1000 \
    -e UMASK=002 \
    -e TZ="Etc/UTC" \
    -e ARGS="" \
    -v /<host_folder_config>:/config \
    hotio/tautulli
```

Compose:

```yaml
version: "3.7"

services:
  tautulli:
    container_name: tautulli
    image: hotio/tautulli
    ports:
      - "8181:8181"
    environment:
      - PUID=1000
      - PGID=1000
      - UMASK=002
      - TZ=Etc/UTC
      - ARGS
    volumes:
      - /<host_folder_config>:/config
```

## Tags

Go [here](https://hotio.dev/tags-overview/#hotiotautulli) to see all available tags.
