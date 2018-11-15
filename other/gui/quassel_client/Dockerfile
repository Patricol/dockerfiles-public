FROM patricol/gui_qt5ct:18.04

RUN apt-get update \
 && apt-get install -y \
    quassel-client \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "sudo chown user:users /config" >> /usr/local/bin/startapp \
 && echo "ln -sf /home/user/.config/qt5ct/ /config/qt5ct" >> /usr/local/bin/startapp \
 && echo "exec env XDG_CONFIG_HOME=/config quasselclient --platformtheme qt5ct" >> /usr/local/bin/startapp

VOLUME /config
