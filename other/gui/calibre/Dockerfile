FROM patricol/gui_qt5ct:18.04

#https://calibre-ebook.com/download_linux

RUN apt-get update \
 && apt-get install -y \
    xdg-utils \
    wget \
    xz-utils \
    python \
    libc-dev \
    gcc \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin \
 && echo "wget -nv -O- https://download.calibre-ebook.com/linux-installer.sh | sh /dev/stdin" >> /update \
 && echo "sudo chown user:users /config /library" >> /usr/local/bin/startapp \
 && echo "ln -sf /home/user/.config/qt5ct/ /config/qt5ct" >> /usr/local/bin/startapp \
 && echo "exec env XDG_CONFIG_HOME=/config QT_QPA_PLATFORMTHEME=qt5ct calibre" >> /usr/local/bin/startapp

EXPOSE 8081

VOLUME /config
VOLUME /library