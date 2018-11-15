FROM alpine:latest

COPY sshd_config /etc/default/sshd/sshd_config
COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache \
    openssh \
    pwgen \
 && mkdir -p /etc/default/sshd \
 && chmod +x /entrypoint.sh \
 && passwd -d root \
 && passwd -l root

VOLUME /config
VOLUME /data

EXPOSE 22

ENTRYPOINT ["/entrypoint.sh"]