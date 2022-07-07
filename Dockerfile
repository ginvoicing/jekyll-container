FROM ruby:2.7.6-alpine

LABEL maintainer="Tarun Jangra <tarun.jangra@hotmail.com>"
ENV LANG C.UTF-8

ENV APP_SOURCE=/home/jekyll/src

RUN \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN set -ex \
    \
    && apk add --no-cache --virtual .build-jekyll build-base binutils-gold \
    curl g++ gcc gnupg libgcc linux-headers make tar zip xz openjdk11-jre \
    readline libxml2  libxslt libxml2-utils \
    zlib  yaml fontforge libffi nginx aspell aspell-en  \
    graphviz gnuplot libcurl curl readline-dev libxml2-dev \
    zlib-dev libxslt-dev yaml-dev libffi-dev openssl zlib nodejs yarn\
    libressl libressl-dev libc6-compat openblas-dev dpkg lapack-dev

RUN set -ex \
    \
    &&  mkdir -p /home/jekyll && \
    addgroup -Sg 1000 jekyll && \
    adduser -SG jekyll -u 1000 -s /bin/sh -h /home/jekyll jekyll && \
    chown jekyll:jekyll /home/jekyll && \
    echo 'jekyll ALL=NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir ${APP_SOURCE} && \
    chown jekyll:jekyll ${APP_SOURCE}


ADD install_cmake.sh /tmp/install_cmake.sh
ADD install_sfnt2woff.sh /tmp/install_sfnt2woff.sh
ADD install_tidy.sh /tmp/install_tidy.sh
ADD install_plantuml.sh /tmp/install_plantuml.sh

WORKDIR ${APP_SOURCE}

# #Install Aditional packages for jekyll
RUN set -ex \
    \
    && /tmp/install_cmake.sh \
    /tmp/install_sfnt2woff.sh \
    /tmp/install_tidy.sh 

ADD giwww.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/install*
