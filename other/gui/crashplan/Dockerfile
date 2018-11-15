FROM patricol/gui_base:arch


RUN /update \
 && su user -c 'aurman -S --noconfirm --noedit --pgp_fetch --skip_news --skip_new_locations crashplan-pro' \
 && echo "sudo chown user:users /config" >> /usr/local/bin/startapp \
 && echo "exec CrashPlanDesktop" >> /usr/local/bin/startapp \
 && yes | pacman -Scc
# && mkdir /defaults \
# && mv /opt/crashplan/conf /defaults/conf \
# && mkdir /config/conf \
# && ln -s /config/conf /opt/crashplan/conf \
# The run.conf file should be stored outside the container.
# && ln -s /config/bin/run.conf /opt/crashplan/bin/run.conf \
# The cache directory should be stored outside the container.
# && ln -s /config/cache /opt/crashplan/cache \
# The log directory should be stored outside the container.
# && rm -r /opt/crashplan/log \
# && ln -s /config/log /opt/crashplan/log \
# The '/var/lib/crashplan' directory should be stored outside the container.
# && ln -s /config/var /var/lib/crashplan \
# The '/repository' directory should be stored outside the container.
# NOTE: The '/repository/metadata' directory changed in 6.7.0 changed to
#       '/usr/local/crashplan/metadata' in 6.7.1.
# && ln -s /config/repository/metadata /usr/local/crashplan/metadata

VOLUME /config
VOLUME /cache
VOLUME /storage
VOLUME /flash


# Enable log monitoring.
#RUN \
#    sed-patch 's|LOG_FILES=|LOG_FILES=/config/log/service.log.0|' /etc/logmonitor/logmonitor.conf && \
#    sed-patch 's|STATUS_FILES=|STATUS_FILES=/config/log/app.log|' /etc/logmonitor/logmonitor.conf
#
#COPY rootfs/ /
#RUN  \
    # Remove the 'nobody' user.  This is to avoid issue when the container is
    # running under ID 65534.
#    sed-patch '/^nobody:/d' /defaults/passwd && \
#    sed-patch '/^nobody:/d' /defaults/group && \
#    sed-patch '/^nobody:/d' /defaults/shadow && \
#cp crashplan-install/scripts/run.conf /defaults/