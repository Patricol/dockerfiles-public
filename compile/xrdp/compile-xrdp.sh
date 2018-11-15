#!/bin/bash

# Update to match this: https://github.com/neutrinolabs/pulseaudio-module-xrdp/wiki/README

set -e

mkdir -p $SAVEDIR

mv /tmp/install-xrdp.sh $SAVEDIR/install-xrdp.sh

#XRDP's dependencies: (https://github.com/neutrinolabs/xrdp/wiki/Building-on-Debian-8)
export XRDP_DEPENDENCIES="git autoconf libtool pkg-config gcc g++ make libssl-dev libpam0g-dev libjpeg-dev libx11-dev libxfixes-dev libxrandr-dev flex bison libxml2-dev intltool xsltproc xutils-dev python-libxml2 g++ xutils libfuse-dev libmp3lame-dev nasm libpixman-1-dev xserver-xorg-dev"


export DEBIAN_FRONTEND=noninteractive
sed -i "s/# deb-src/deb-src/g" /etc/apt/sources.list
apt-get update; \
    apt-get install -y \
	sudo apt-utils software-properties-common wget ca-certificates \
	checkinstall \
	pulseaudio \
	$XRDP_DEPENDENCIES && \
	apt-get build-dep -yy pulseaudio

export PULSEAUDIO_VERSION=`pulseaudio --version | grep -oE '[^ ]+$'`

cd /tmp && \
    git clone --branch v$XRDP_VERSION --recursive https://github.com/neutrinolabs/xrdp.git && \
    git clone --branch v$XORGXRDP_VERSION --recursive https://github.com/neutrinolabs/xorgxrdp.git && \
    apt-get source pulseaudio

cd /tmp/pulseaudio-$PULSEAUDIO_VERSION && \
    dpkg-buildpackage -rfakeroot -uc -b

cd /tmp/xrdp && \
    ./bootstrap && \
    ./configure && \
    make && \
    checkinstall -D -y --pkgversion $XRDP_VERSION && \
    mv /tmp/xrdp/xrdp_$XRDP_VERSION-1_amd64.deb $SAVEDIR/xrdp.deb

#https://github.com/neutrinolabs/xrdp/wiki/Audio-Output-Virtual-Channel-support-in-xrdp
cd /tmp/xrdp/sesman/chansrv/pulse && \
    sed -i "s/PULSE_DIR = .*/PULSE_DIR = \/tmp\/pulseaudio-$PULSEAUDIO_VERSION/g" Makefile && \
    make && \
    mkdir -p $SAVEDIR/pulse_xrdp_sink/pulse-$PULSEAUDIO_VERSION/modules/ && \
    cp *.so /usr/lib/pulse-$PULSEAUDIO_VERSION/modules/ && \
    cp *.so $SAVEDIR/pulse_xrdp_sink/pulse-$PULSEAUDIO_VERSION/modules/

cd /tmp/xorgxrdp && \
    ./bootstrap && \
    ./configure && \
    make && \
    checkinstall -D -y --pkgversion $XORGXRDP_VERSION && \
    mv /tmp/xorgxrdp/xorgxrdp_$XORGXRDP_VERSION-1_amd64.deb $SAVEDIR/xorgxrdp.deb
