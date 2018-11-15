FROM patricol/gui_base:18.04

RUN apt-get update \
 && apt-get install -y \
    virt-manager \
    openssh-client \
    ssh-askpass \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "sudo chown user:users /config" >> /usr/local/bin/startapp \
 && echo "exec env XDG_CONFIG_HOME=/config virt-manager" >> /usr/local/bin/startapp

VOLUME /config
