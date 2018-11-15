FROM patricol/arch

USER root

ENV RESOLUTION="1920x1080"
ENV PASSWORD="8CharMax"

RUN pacman -Syu --noconfirm \
 && pacman -S --noconfirm i3-wm tigervnc xorg-twm xterm \
 && mkdir -p /home/user/.vnc \
 && touch /home/user/.vnc/passwd \
 && echo '#!/bin/bash' >> /home/user/.vnc/xstartup \
 && echo 'exec i3' >> /home/user/.vnc/xstartup \
 && chown -R user:users /home/user/.vnc \
 && chmod -R go-rwx /home/user/.vnc \
 && chmod 755 /home/user/.vnc/xstartup \
 && touch /usr/local/bin/startapp \
 && chmod a+x /usr/local/bin/startapp \
 && echo "su user -c 'aurman -Syu --noconfirm --noedit --pgp_fetch --skip_news --skip_new_locations'" >> /update \
 && echo "echo \"\$PASSWORD\" | vncpasswd -f >> /home/user/.vnc/passwd" >> /setup \
 && echo "rm -f /tmp/.X0-lock /tmp/.X11-unix/X0" >> /setup \
 && echo "/update" >> /setup \
 && echo "su user -c \"vncserver :0 -fg -geometry \$RESOLUTION\"" >> /setup \
 && chmod +x /setup /update \
 && yes | pacman -Scc

COPY extras/i3-config /home/user/.config/i3/config
RUN chown -R user:users /home/user/.config/

EXPOSE 5900

CMD /setup