FROM base/devel

RUN groupadd -r sudo \
 && useradd -u 99 -m -g users -G sudo -s /bin/bash user \
 && echo '%sudo  ALL=(ALL) NOPASSWD:ALL' >> /etc/sudoers \
 && pacman -Syu --noconfirm \
 && pacman -S --noconfirm git vim \
 && sed -i '/^#en_US.UTF-8 UTF-8/s/^#//' /etc/locale.gen \
 && locale-gen \
 && echo 'LANG=en_US.UTF-8' | tee -a /etc/locale.conf \
 && yes | pacman -Scc

USER user

WORKDIR /home/user

RUN gpg --keyserver keyserver.ubuntu.com --recv 465022E743D71E39 \
 && git clone https://aur.archlinux.org/aurman.git \
 && cd aurman \
 && makepkg -sci --noconfirm \
 && cd .. \
 && rm -rf ./aurman/ \
 && yes | sudo pacman -Scc


CMD tail -f /dev/null