#!/bin/bash

set -e

dpkg -i $(dirname $0)/xrdp.deb
cp -r $(dirname $0)/pulse_xrdp_sink/* /usr/lib/
dpkg -i $(dirname $0)/xorgxrdp.deb
apt-get update
apt-get install -yf
apt-get -y clean
rm -rf /var/lib/apt/lists/*
rm -rf $(dirname $0)/
