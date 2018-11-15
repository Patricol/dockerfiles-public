FROM patricol/ubuntu_x11:18.04

USER root

RUN apt-get update; \
    apt-get install -y \
    g++ gcc make gdb gdbserver \
    cmake valgrind ddd && \
    apt-get -y clean && \
    rm -rf /var/lib/apt/lists/*

RUN su user -c "umake ide clion /home/user/.local/share/umake/ide/clion"

USER user