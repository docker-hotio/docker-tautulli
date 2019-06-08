# [Tautulli](https://github.com/Tautulli/Tautulli)

[![badge](https://images.microbadger.com/badges/image/hotio/tautulli.svg)](https://microbadger.com/images/hotio/tautulli "Get your own image badge on microbadger.com")
[![badge](https://images.microbadger.com/badges/version/hotio/tautulli.svg)](https://microbadger.com/images/hotio/tautulli "Get your own version badge on microbadger.com")
[![badge](https://images.microbadger.com/badges/commit/hotio/tautulli.svg)](https://microbadger.com/images/hotio/tautulli "Get your own commit badge on microbadger.com")

## Donations

NANO: `xrb_1bxqm6nsm55s64rgf8f5k9m795hda535to6y15ik496goatakpupjfqzokfc`  
BTC: `39W6dcaG3uuF5mZTRL4h6Ghem74kUBHrmz`  
LTC: `MMUFcGLiK6DnnHGFnN2MJLyTfANXw57bDY`

## Starting the container

Just the basics to get the container running:

```shell
docker run --rm --name tautulli -p 8181:8181 -v /tmp/tautulli:/config -e TZ=Etc/UTC hotio/tautulli
```

The environment variables `PUID`, `PGID`, `UMASK`, `VERSION` and `BACKUP` are all optional, the values you see below are the default values.

By default the image comes with a stable version. You can however install a different version with the environment variable `VERSION`. The value `image` does nothing, but keep the included version, all the others install a different version when starting the container.

```shell
-e PUID=1000
-e PGID=1000
-e UMASK=022
-e VERSION=image
-e BACKUP=yes
```

Possible values for `VERSION`:

```shell
VERSION=image
VERSION=stable
VERSION=unstable
VERSION=https://github.com/Tautulli/Tautulli/archive/v2.1.14.tar.gz
VERSION=file:///config/v2.1.14.tar.gz
```

## Backing up the configuration

By default on every docker container shutdown a backup is created from the configuration files. You can change this behaviour.

```shell
-e BACKUP=no
```

## Using a rclone mount

Mounting a remote filesystem using `rclone` can be done with the environment variable `RCLONE`. Use `docker exec -it --user hotio CONTAINERNAME rclone config` to configure your remote when the container is running. Configuration files for `rclone` are stored in `/config/.config/rclone`.

```shell
-e RCLONE="remote1:path/to/files,/localmount1|remote2:path/to/files,/localmount2"
```

## Using a rar2fs mount

Mounting a filesystem using `rar2fs` can be done with the environment variable `RAR2FS`. The new mount will be read-only. Using a `rar2fs` mount makes the use of an unrar script obsolete. You can mount a `rar2fs` mount on top of an `rclone` mount, `rclone` mounts are mounted first.

```shell
-e RAR2FS="/folder1-rar,/folder1-unrar|/folder2-rar,/folder2-unrar"
```

## Extra docker privileges

In most cases you will need some or all of the following flags added to your command to get the required docker privileges when using a rclone or rar2fs mount.

```shell
--security-opt apparmor:unconfined --cap-add SYS_ADMIN --device /dev/fuse
```

## Execute scripts at startup

If you need additional dependencies for your pp-scripts, you can install these by placing your script in the folder `/config/scripts.d`, an example script can be seen below. This script would install the `sickbeard_mp4_automator` scripts and its dependencies.

```shell
#!/bin/bash

if [[ ! -d /sma ]]; then
  apt update
  apt install -y --no-install-recommends --no-install-suggests python-pip python-setuptools ffmpeg
  pip --no-cache-dir install requests requests[security] requests-cache babelfish stevedore==1.19.1 python-dateutil deluge-client qtfaststart "guessit<2" "subliminal<2"
  mkdir /sma
  curl -fsSL "https://github.com/mdhiggins/sickbeard_mp4_automator/archive/c29bde3b2b4cfc194e5bb3a868b248acd2780d89.tar.gz" | tar xzf - -C "/sma" --strip-components=1
fi
```
