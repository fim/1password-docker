FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Serafeim Mellos <fim@mellos.io>

# Set wine prefix
ENV WINEPREFIX /wine

# Setting up the wineprefix to force 32 bit architecture.
ENV WINEARCH win32

# Disabling warning messages from wine, comment for debug purpose.
ENV WINEDEBUG -all

# DLL overrides for wine
ENV WINEDLLOVERRIDES mscoree,mshtml=

# 1password URL
ARG ONEPASSWORD_URL=https://app-updates.agilebits.com/download/OPW4

ADD start_1password.sh /usr/local/bin

# Install command shamelessly borrowed from geekylucas/dockerfiles
RUN dpkg --add-architecture i386 && \
    apt-get update && apt-get install -y curl software-properties-common && \
    add-apt-repository -y ppa:ubuntu-wine/ppa && \
    apt-get update -y && apt-get install -y wine1.8 winetricks xvfb xauth && \
    curl -L -o /tmp/1Password.exe $ONEPASSWORD_URL && \
    xvfb-run -a /bin/bash -c "WINEDEBUG= wine /tmp/1Password.exe /VERYSILENT /DIR=C:\\1Password" && \
    wineserver --wait && apt-get remove -y curl xvfb xauth && \
    SUDO_FORCE_REMOVE=yes apt-get autoremove -y && \
    rm /tmp/1Password.exe && rm -rf /var/lib/apt/lists/*

EXPOSE 6258

CMD ["/usr/local/bin/start_1password.sh"]
