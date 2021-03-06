USER root

# This should have VNC plus basic desktop environment.
# VNC is the most reliable connection type, and the simplest to configure/fix.
# When debugging adding compatibility for a new OS version, this is simpler than noVNC/RDP, and also includes all the things needed to check that the environment behaves as normal, before attempting to add compatibility for additional connection methods.
# This also allows for the more finicky noVNC/RDP images to build more quickly; as desktop environment and some basic programs are are installed here.

# Need to setup ssh tunneling too to make this secure.

ENV TURBOVNC_VERSION=2.1.90
ENV TURBOVNC_VERSION_BETAENDING="%20%282.2beta1%29"
ENV VIRTUALGL_VERSION=2.5.2

RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    x11-xkb-utils \
    x11-xserver-utils \
    i3 \
    pwgen \
    xauth \
    xterm \
    libglu1-mesa \
    mesa-utils && \
# For testing glxgears etc.
    wget "https://sourceforge.net/projects/turbovnc/files/"$TURBOVNC_VERSION$TURBOVNC_VERSION_BETAENDING"/turbovnc_"$TURBOVNC_VERSION"_amd64.deb/download" -O turbovnc.deb && \
    wget "https://sourceforge.net/projects/virtualgl/files/"$VIRTUALGL_VERSION"/virtualgl_"$VIRTUALGL_VERSION"_amd64.deb/download" -O virtualgl.deb && \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    ./turbovnc.deb \
    ./virtualgl.deb && \
    rm ./turbovnc.deb ./virtualgl.deb && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    setcap -r `which i3status` && \
    echo "/opt/VirtualGL/bin/vglserver_config -config +s +f" >> /home/user/earlycommands.sh
    
ENV PATH=/opt/TurboVNC/bin:$PATH

EXPOSE 5900
ENV USER user
RUN echo "PASSWORD=\`pwgen -c -n -1 8\`" >> /home/user/earlycommands.sh && \
    echo "echo -e \"Password: \$PASSWORD\" > /home/user/password.txt" >> /home/user/earlycommands.sh && \
    echo "echo \"user:\$PASSWORD\" | chpasswd" >> /home/user/earlycommands.sh && \
    mkdir -p /home/user/.vnc && \
    echo "vglrun i3 &" | tee -a /home/user/.vnc/xstartup.turbovnc && \
    chmod +x /home/user/.vnc/xstartup.turbovnc && \
    echo "echo \$PASSWORD | /opt/TurboVNC/bin/vncpasswd -f > /home/user/.vnc/passwd" >> /home/user/earlycommands.sh && \
    echo "chown -R user:user /home/user/.vnc" >> /home/user/earlycommands.sh && \
    echo "chmod 600 /home/user/.vnc/passwd" >> /home/user/earlycommands.sh && \
    echo '#!/bin/bash\ncat /home/user/password.txt\nvncserver :0 -geometry `cat /home/user/.resolution | tr -d '\r\n'`' > /home/user/vnc.sh && \
    chmod +x /home/user/vnc.sh && \
    echo "chown user:user /home/user/*" >> /home/user/earlycommands.sh && \
    echo "800x600" > /home/user/.resolution

USER user