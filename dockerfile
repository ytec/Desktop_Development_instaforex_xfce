FROM debian:jessie

ENV DEBIAN_FRONTEND noninteractive
ENV LC_ALL C
ENV LANG es_ES.UTF-8
ENV LANGUAGE es_ES.UTF-8
ENV LC_TIME es_ES.UTF-8
ENV LC_MONETARY es_ES.UTF-8
ENV LC_ADDRESS es_ES.UTF-8
ENV LC_TELEPHONE es_ES.UTF-8
ENV LC_NAME es_ES.UTF-8
ENV LC_MEASUREMENT es_ES.UTF-8
ENV LC_IDENTIFICATION es_ES.UTF-8
ENV LC_NUMERIC es_ES.UTF-8
ENV LC_PAPER es_ES.UTF-8
ENV LC_CTYPE es_ES.UTF-8
ENV LC_MESSAGES es_ES.UTF-8

RUN apt-get update

RUN apt-get install -y apt-utils \
    && apt-get install -y locales

RUN apt-get install -y xfce4
EXPOSE 6000

RUN apt-get install -y python3 python3-pip git wget
RUN apt-get install -y zlib1g-dev libjpeg-dev
CMD ["bash"] \
    && cd /opt \
    && wget https://download-installer.cdn.mozilla.net/pub/firefox/nightly/latest-mozilla-aurora-l10n/firefox-54.0a2.es-ES.linux-x86_64.tar.bz2 \
    && tar -jxvf firefox-54.0a2.es-ES.linux-x86_64.tar.bz2 \
    && rm firefox-54.0a2.es-ES.linux-x86_64.tar.bz2 \
    && mkdir /var/instaforex \
    && cd /var/instaforex \
    && git clone https://github.com/ytec/instaforex-web.git \
    && pip3 install -r /var/instaforex/instaforex-web/requirements.txt

EXPOSE 8000
