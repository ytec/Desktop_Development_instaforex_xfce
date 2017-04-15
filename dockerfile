FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
RUN echo ' \
    LC_ALL="es_ES.UTF-8" \
    LANG="es_ES.UTF-8" \
    LANGUAGE="es_ES.UTF-8" \
    LC_TIME="es_ES.UTF-8" \
    LC_MONETARY="es_ES.UTF-8" \
    LC_ADDRESS="es_ES.UTF-8" \
    LC_TELEPHONE="es_ES.UTF-8" \
    LC_NAME="es_ES.UTF-8" \
    LC_MEASUREMENT="es_ES.UTF-8" \
    LC_IDENTIFICATION="es_ES.UTF-8" \
    LC_NUMERIC="es_ES.UTF-8" \
    LC_PAPER="es_ES.UTF-8" \
    LC_CTYPE="es_ES.UTF-8" \
    LC_MESSAGES="es_ES.UTF-8" \
      '> /etc/default/locale
RUN apt-get update

RUN apt-get install -y apt-utils \
    && apt-get install -y locales \
    && dpkg-reconfigure locales

RUN apt-get install -y xfce4
EXPOSE 6000

RUN apt-get install -y ssh nano \
    && service ssh start

RUN apt-get install -y python3 python3-pip git wget
RUN apt-get install -y zlib1g-dev libjpeg-dev

RUN cd /opt \
    && wget https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora-l10n/firefox-54.0a2.es-ES.linux-x86_64.tar.bz2 \
    && tar -jxvf firefox-54.0a2.es-ES.linux-x86_64.tar.bz2 \
    && rm firefox-54.0a2.es-ES.linux-x86_64.tar.bz2

RUN mkdir /var/instaforex \
    && cd /var/instaforex \
    && git clone https://github.com/ytec/instaforex-web.git \
    && pip3 install -r /var/instaforex/instaforex-web/requirements.txt

EXPOSE 8000
