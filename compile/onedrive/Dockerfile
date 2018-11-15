FROM ubuntu:latest as ubuntu

#Remake when this container exists: https://hub.docker.com/r/dlang2/dmd-alpine/

#Check newest version here: http://downloads.dlang.org/releases/2.x/
ENV DMD_MAJOR_VER=2.x
ENV DMD_FULL_VER=2.080.0


RUN apt-get update -y && \
    apt-get install -y wget gcc unzip make git libcurl4-openssl-dev libsqlite3-dev && \
    wget http://downloads.dlang.org/releases/${DMD_MAJOR_VER}/${DMD_FULL_VER}/dmd_${DMD_FULL_VER}-0_amd64.deb -O dmd.deb && \
    dpkg -i dmd.deb && \
    git clone https://github.com/skilion/onedrive.git && \
    cd onedrive && \
    make && \
    make install

FROM scratch
COPY --from=ubuntu /usr/local/bin/onedrive /onedrive
COPY --from=ubuntu /usr/lib/systemd/user/onedrive.service /onedrive.service
