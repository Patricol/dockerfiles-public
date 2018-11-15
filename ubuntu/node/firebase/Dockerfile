FROM patricol/node:18.04
USER root

RUN npm install --unsafe-perm -g \
    firebase \
    firebase-tools \
    react \
    react-dom \
    material-ui \
    react-tap-event-plugin

RUN echo '#!/bin/bash\nfirebase login --no-localhost' > /home/user/login.sh && \
    chmod +x /home/user/login.sh && \
    chown -R user:user /home/user/login.sh

USER user