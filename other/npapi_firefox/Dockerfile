FROM patricol/ubuntu_x11:18.04

USER root

# Saved as a binary for future-proofness; this container is meant for historical preservation of old NPAPI applications.
COPY extras/firefox-52.9.0esr.tar.bz2 /home/user/firefox.tar.bz2

RUN cd /home/user/ \
 && tar xvjf firefox.tar.bz2 \
 && rm firefox.tar.bz2 \
 && ln -s /home/user/firefox/firefox /usr/local/bin/firefox

# For mounting a folder with swf/dcr files etc.
VOLUME /data

USER user

# Next steps:
# Disable auto-updating etc.
# Sane basic settings for firefox, so it won't do basic setup every time it is run.
# Include binaries of all necessary NPAPI plugins etc.
# Rebase off of a more minimal image that gives easy GUI access.
# Just setup RDP probably; and use guac to connect. 

# Check reqs:
#Firefox will not run at all without the following libraries or packages:
# GTK+ 3.4 or higher
# GLib 2.22 or higher
# Pango 1.22 or higher
# X.Org 1.0 or higher (1.7 or higher is recommended)
# libstdc++ 4.6.1 or higher
#For optimal functionality, we recommend the following libraries or packages:
# NetworkManager 0.7 or higher
# DBus 1.0 or higher
# GNOME 2.16 or higher
# PulseAudio
# Those reqs are for v62

# sudo add-apt-repository ppa:jonathonf/firefox-esr-52
# sudo apt-get install firefox-esr
#https://www.mozilla.org/en-US/firefox/52.0/system-requirements/
# Shockwave never had a linux version. That might actually simplify things; not having to worry about dependencies. Install the windows exes in wine.