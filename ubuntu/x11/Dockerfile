USER root

# This should add things I want every GUI workspace to have, but that aren't needed for setting up or validating the various connection methods.

RUN add-apt-repository -y ppa:lyzardking/ubuntu-make && \
# For daily builds of umake
    add-apt-repository -y ppa:remmina-ppa-team/remmina-next && \
    apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    terminator \
    chromium-browser \
    neofetch \
    screen \
    tree \
    htop \
    dbus-x11 \
#Needed by terminator and misc others.
    libgconf-2-4 \
#Needed by atom but currently not installed by umake.
    libsecret-1-0 gnome-keyring \
#Needed by IntelliJ IDEs to store credentials
    remmina \
# For connecting to other VMs
    ubuntu-make && \
# Adding umake because it's used by just about every sub-container; to install IDEs.
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    su user -c "umake ide atom /home/user/.local/share/umake/ide/atom" && \
    echo "chmod +x /home/user/.local/share/applications/*.desktop" >> /home/user/earlycommands.sh

ENV PATH=/home/user/.local/share/umake/bin:$PATH
#This path addition is also needed for programs installed later on.

#COPY --chown=user:user extras/i3-config /home/user/.config/i3/config#Not yet supported by docker hub's automated builds, which use an outdated version of docker.
COPY extras/i3-config /home/user/.config/i3/config
#COPY --chown=user:user extras/i3status-config /home/user/.config/i3status/config#Not yet supported by docker hub's automated builds, which use an outdated version of docker.
COPY extras/i3status-config /home/user/.config/i3status/config
RUN chown -R user:user /home/user/.config/

COPY extras/config.cson /home/user/.atom/
RUN chown -R user:user /home/user/.atom/ && \
    chmod 0664 /home/user/.atom/config.cson && \
    su user -c "/home/user/.local/share/umake/bin/apm install file-icons highlight-selected jumpy language-docker script sort-lines" && \
    su user -c "/home/user/.local/share/umake/bin/apm disable spell-check tree-view"

USER user