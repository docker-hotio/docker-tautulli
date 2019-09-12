FROM hotio/base

ARG DEBIAN_FRONTEND="noninteractive"

EXPOSE 8181
HEALTHCHECK --interval=60s CMD curl -fsSL http://localhost:8181 || exit 1

# install packages
RUN apt update && \
    apt install -y --no-install-recommends --no-install-suggests \
        python-pkg-resources python-pycryptodome && \
# clean up
    apt autoremove -y && \
    apt clean && \
    rm -rf /tmp/* /var/lib/apt/lists/* /var/tmp/*

COPY root/ /

# install app
RUN version=$(sed -n '1p' /versions/tautulli) && \
    curl -fsSL "https://github.com/Tautulli/Tautulli/archive/v${version}.tar.gz" | tar xzf - -C "${APP_DIR}" --strip-components=1 && \
    chmod -R u=rwX,go=rX "${APP_DIR}"
