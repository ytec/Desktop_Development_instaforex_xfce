FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive

RUN apt-get update
RUN apt-get install -y git wget
RUN apt-get install -y apt-utils \
    && apt-get install -y locales
RUN rm /etc/default/locale \
    && cd /etc/default/ \
    && wget https://raw.githubusercontent.com/ytec/Desktop_xfce_Development_instaforex/master/locale

RUN dpkg-reconfigure locales

RUN apt-get install -y xfce4
EXPOSE 6000
ENV DISPLAY 0.0

RUN apt-get install -y ssh nano \
    && service ssh start

RUN apt-get install -y python3 python3-pip
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
