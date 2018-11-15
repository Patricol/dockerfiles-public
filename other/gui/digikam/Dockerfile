FROM patricol/gui_qt5ct:18.04

RUN apt-get update \
 && apt-get install -y \
    digikam \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "sudo chown user:users /config /data /home/user/.local" >> /usr/local/bin/startapp \
 && echo "mkdir -p /config/share/ /config/general/" >> /usr/local/bin/startapp \
 && echo "ln -sf /home/user/.config/qt5ct/ /config/general/qt5ct" >> /usr/local/bin/startapp \
 && echo "exec env XDG_CONFIG_HOME=/config/general digikam --platformtheme qt5ct" >> /usr/local/bin/startapp \
 && mkdir -p /config/share /home/user/.local \
 && ln -s /config/share/ /home/user/.local/share \
 && chown -R user:users /home/user/.local

VOLUME /config
VOLUME /data
