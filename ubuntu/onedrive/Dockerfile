FROM patricol/compile:onedrive as onedrive

#Rebase on alpine when this container exists: https://hub.docker.com/r/dlang2/dmd-alpine/

FROM ubuntu:latest

COPY --from=onedrive /onedrive /usr/local/bin/onedrive
COPY --from=onedrive /onedrive.service /usr/lib/systemd/user/onedrive.service
COPY default_config /
COPY entrypoint.sh /

RUN apt-get update -y && \
    apt-get install -y libsqlite3-dev libcurl4-openssl-dev && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    chmod +x /entrypoint.sh && \
    mkdir -p ~/.config/ && \
    ln -s /config ~/.config/onedrive

VOLUME /config
VOLUME /data

ENTRYPOINT ["/entrypoint.sh"]

CMD ["-m"]