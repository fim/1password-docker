FROM ubuntu:latest
ENV DEBIAN_FRONTEND noninteractive
MAINTAINER Serafeim Mellos <fim@mellos.io>

# Setting up the wineprefix to force 32 bit architecture.
ENV WINEARCH win32

# Disabling warning messages from wine, comment for debug purpose.
ENV WINEDEBUG -all

RUN dpkg --add-architecture i386

RUN apt-get update -y && apt-get install -y software-properties-common && add-apt-repository -y ppa:ubuntu-wine/ppa
RUN apt-get update -y && apt-get install -y wine1.8 winetricks xvfb xauth

ADD https://app-updates.agilebits.com/download/OPW4 /tmp/1Password.exe

# Install command shamelessly borrowed from geekylucas/dockerfiles
RUN WINEDLLOVERRIDES=mscoree=d xvfb-run wine /tmp/1Password.exe /VERYSILENT /DIR=c:\1Password

EXPOSE 6258

CMD ["wine", "/wine/drive_c/1Password/1Password.exe"]
