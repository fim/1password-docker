FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Serafeim Mellos <fim@mellos.io>

# Set wine prefix
ENV WINEPREFIX /wine

# Setting up the wineprefix to force 32 bit architecture.
ENV WINEARCH win32

# Disabling warning messages from wine, comment for debug purpose.
ENV WINEDEBUG -all

# Install requirements
RUN dpkg --add-architecture i386
RUN apt-get update -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update -y && apt-get install -y wine1.8 winetricks xvfb xauth

ADD https://app-updates.agilebits.com/download/OPW4 /tmp/1Password.exe
ADD start_1password.sh /usr/local/bin

ENV WINEDLLOVERRIDES mscoree,mshtml=
# Install command shamelessly borrowed from geekylucas/dockerfiles
RUN xvfb-run -a /bin/bash -c "WINEDEBUG= wine /tmp/1Password.exe /VERYSILENT /DIR=C:\\1Password" && wineserver --wait

EXPOSE 6258

CMD ["/usr/local/bin/start_1password.sh"]
