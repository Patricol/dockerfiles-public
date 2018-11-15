FROM patricol/gui_base:18.04


RUN apt-get update \
 && apt-get install -y \
    wget \
    gnupg \
 && wget -q -O - https://dl.google.com/linux/linux_signing_key.pub | apt-key add - \
 && wget -O ./gmm.deb https://dl.google.com/linux/direct/google-musicmanager-beta_current_amd64.deb \
 && apt-get install -y ./gmm.deb \
 && rm ./gmm.deb \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "sudo chown user:users /config" >> /usr/local/bin/startapp \
 && echo "exec env XDG_CONFIG_HOME=/config google-musicmanager" >> /usr/local/bin/startapp

VOLUME /config
