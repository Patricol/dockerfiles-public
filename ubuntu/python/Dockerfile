FROM patricol/ubuntu_x11:18.04

USER root

RUN apt-get update; \
    DEBIAN_FRONTEND=noninteractive apt-get install -y \
    python \
    python-pip \
    python3 \
    python3-pip && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/* && \
    # pip install --no-cache-dir -U pip setuptools
    # Currently breaks pip. https://github.com/pypa/pip/issues/5240
    # Setup Pycharm
    su user -c "umake ide pycharm /home/user/.local/share/umake/ide/pycharm" && \
    su user -c "umake ide pycharm-professional /home/user/.local/share/umake/ide/pycharm-professional"

USER user