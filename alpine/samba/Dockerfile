FROM alpine:latest

COPY smb.conf /etc/default/samba/smb.conf
COPY entrypoint.sh /entrypoint.sh

RUN apk add --no-cache \
    samba-common-tools \
    samba-client \
    samba-server \
    pwgen \
 && rm -rf /var/cache/apk/* \
 && adduser -DH -u 99 -G users -s /sbin/nologin defuid \
 && passwd -d defuid \
 && passwd -l defuid \
 && chmod +x /entrypoint.sh
#test with just the samba-server

VOLUME /config
VOLUME /data

EXPOSE 445

ENTRYPOINT ["/entrypoint.sh"]

CMD []
