FROM hotio/base@sha256:b7f9f793ba275ea953ce4979b7a7c86e35ec3c2a93ca5932d0e0845ede0b3367

ARG DEBIAN_FRONTEND="noninteractive"

ENV TAUTULLI_DOCKER="True"

EXPOSE 8181

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python3-pkg-resources libxml2 libxslt1.1 \
        python3-pip python3-setuptools build-essential python3-all-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev && \
    pip3 install --no-cache-dir --upgrade plexapi pyopenssl pycryptodomex lxml && \
# clean up
    apt purge -y python3-pip python3-setuptools build-essential python3-all-dev libffi-dev libssl-dev libxml2-dev libxslt1-dev && \
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

ARG TAUTULLI_VERSION

# install app
RUN curl -fsSL "https://github.com/Tautulli/Tautulli/archive/v${TAUTULLI_VERSION}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}" && \
    echo "None" > "${APP_DIR}/version.txt" && \
    echo "None" > "${APP_DIR}/version.lock" && \
    echo "v${TAUTULLI_VERSION}" > "${APP_DIR}/release.lock"

COPY root/ /
