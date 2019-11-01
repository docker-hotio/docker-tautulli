# tautulli

[![GitHub](https://img.shields.io/badge/source-github-lightgrey?style=flat-square)](https://github.com/hotio/docker-tautulli)
[![Docker Pulls](https://img.shields.io/docker/pulls/hotio/tautulli?style=flat-square)](https://hub.docker.com/r/hotio/tautulli)
[![Drone (cloud)](https://img.shields.io/drone/build/hotio/docker-tautulli?style=flat-square)](https://cloud.drone.io/hotio/docker-tautulli)

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name tautulli -p 8181:8181 -v /tmp/tautulli:/config -e TZ=Etc/UTC hotio/tautulli
```

The environment variables below are all optional, the values you see are the defaults.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
```

Possible values for `VERSION`:

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/Tautulli/Tautulli/archive/v2.1.14.tar.gz
VERSION=file:///config/v2.1.14.tar.gz
```

## Executing your own scripts

If you have a need to do additional stuff when the container starts or stops, you can mount your script with `-v /docker/host/my-script.sh:/etc/cont-init.d/99-my-script` to execute your script on container start or `-v /docker/host/my-script.sh:/etc/cont-finish.d/99-my-script` to execute it when the container stops. An example script can be seen below.

```shell
#!/usr/bin/with-contenv bash

echo "Hello, this is me, your script."
```
