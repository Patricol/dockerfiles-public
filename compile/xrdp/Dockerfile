FROM ubuntu:18.04 as ubuntu1804
ENV XRDP_VERSION=0.9.4 XORGXRDP_VERSION=0.2.4 SAVEDIR=/tmp/files_to_save
COPY ./*-xrdp.sh /tmp/
RUN chmod +x /tmp/*-xrdp.sh && sync && /tmp/compile-xrdp.sh

FROM scratch
COPY --from=ubuntu1804 /tmp/files_to_save/ /1804/
