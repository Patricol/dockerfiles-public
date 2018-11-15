FROM ubuntu:18.04


ENV RESOLUTION="1920x1080"
ENV PASSWORD="8CharMax"


ENV LANG="en_US.UTF-8" DEBIAN_FRONTEND="noninteractive"

RUN apt-get update \
 && apt-get upgrade -y \
 && apt-get install -y \
    locales \
    sudo \
    i3-wm \
    tigervnc-standalone-server \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "%sudo ALL=(ALL) NOPASSWD: ALL" >> /etc/sudoers \
 && useradd -u 99 -g users -G sudo --shell /bin/bash -m user \
 && locale-gen $LANG \
 && mkdir -p /home/user/.vnc \
 && touch /home/user/.vnc/passwd \
 && chown -R user:users /home/user/.vnc \
 && chmod -R go-rwx /home/user/.vnc \
 && touch /usr/local/bin/startapp \
 && chmod a+x /usr/local/bin/startapp \
 && echo "apt-get update && apt-get upgrade -y" >> /update \
 && echo "echo \"\$PASSWORD\" | vncpasswd -f >> /home/user/.vnc/passwd" >> /setup \
 && echo "rm -f /tmp/.X0-lock /tmp/.X11-unix/X0" >> /setup \
 && echo "/update" >> /setup \
 && echo "su user -c \"vncserver :0 -fg -localhost no -geometry \$RESOLUTION\"" >> /setup \
 && chmod +x /setup /update

COPY extras/i3-config /home/user/.config/i3/config
RUN chown -R user:users /home/user/.config/

EXPOSE 5900

CMD /setup