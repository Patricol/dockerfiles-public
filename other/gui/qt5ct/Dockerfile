FROM patricol/gui_base:18.04

# Fixes issues with qt5 themes and i3. (anything that's not KDE or GNOME.)
# Also adds and sets Numix theme.

RUN apt-get update \
 && apt-get install -y \
    qt5ct \
    numix-gtk-theme \
    numix-icon-theme \
 && apt-get -y clean \
 && rm -rf /var/lib/apt/lists/* \
 && echo "export QT_QPA_PLATFORMTHEME=qt5ct" | su user -c "tee /home/user/.xprofile"

COPY extras/qt5ct /home/user/.config/qt5ct/

RUN mkdir -p /home/user/.config/qt5ct/qss \
    # Isn't copied over properly.
 && chown -R user:users /home/user/.config/qt5ct
