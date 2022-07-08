FROM ruby:2.7.6-alpine

LABEL maintainer="Tarun Jangra <tarun.jangra@hotmail.com>"
ENV LANG C.UTF-8

ENV APP_SOURCE=/home/jekyll/src

RUN \
    echo "http://dl-4.alpinelinux.org/alpine/edge/testing" >> /etc/apk/repositories

RUN apk --no-cache add \
    zlib-dev \
    libffi-dev \
    build-base \
    libxml2-dev \
    imagemagick-dev \
    readline-dev \
    libxslt-dev \
    libffi-dev \
    yaml-dev \
    zlib-dev \
    vips-dev \
    vips-tools \
    sqlite-dev \
    zlib-dev \
    libxslt-dev \
    yaml-dev \
    libffi-dev \
    lapack-dev \
    openblas-dev \
    libressl-dev \
    libxml2-dev \
    readline-dev

RUN set -ex \
    \
    && apk add --no-cache --virtual \
    build-base \
    binutils-gold \
    curl \
    g++ \
    gcc \
    gnupg \
    libgcc \
    linux-headers \
    make \
    tar \
    zip \
    xz \
    openjdk8-jre \
    readline \
    libxml2 \
    libxslt \
    libxml2-utils \
    su-exec \
    tzdata \
    git \
    zlib \
    yaml \
    fontforge \
    libffi \
    aspell \
    aspell-en  \
    shadow \
    graphviz \
    gnuplot \
    libcurl \
    curl \
    openssl \
    zlib \
    libressl \
    libc6-compat  

RUN set -ex \
    \
    && apk add --no-cache woff2 fontforge

RUN set -ex \
    \
    &&  mkdir -p /home/jekyll && \
    addgroup -Sg 1000 jekyll && \
    adduser -SG jekyll -u 1000 -s /bin/sh -h /home/jekyll jekyll && \
    chown jekyll:jekyll /home/jekyll && \
    echo 'jekyll ALL=NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir ${APP_SOURCE} && \
    chown jekyll:jekyll ${APP_SOURCE}

ENV CMAKE_VERSION=3.23.2

ADD https://github.com/Kitware/CMake/releases/download/v${CMAKE_VERSION}/cmake-${CMAKE_VERSION}.tar.gz /tmp/

RUN tar xf /tmp/cmake-${CMAKE_VERSION}.tar.gz --directory /tmp && cd /tmp/cmake-${CMAKE_VERSION} && ./configure && make && make install 

ADD install_sfnt2woff.sh /tmp/install_sfnt2woff.sh
ADD install_tidy.sh /tmp/install_tidy.sh
ADD entrypoint /


RUN chmod +x /entrypoint
RUN chmod +x /tmp/install_sfnt2woff.sh
RUN chmod +x /tmp/install_tidy.sh

WORKDIR ${APP_SOURCE}
VOLUME  ${APP_SOURCE}

RUN set -ex \
    \
    /tmp/install_sfnt2woff.sh && \
    /tmp/install_tidy.sh
ENV JEKYLL_VERSION=4.2.2
# Stops slow Nokogiri!
RUN gem install jekyll -v ${JEKYLL_VERSION} -- --use-system-libraries --no-ri --no-rdoc
RUN gem install \
    rake \
    sass \
    jekyll-feed \
    jekyll-gist \
    jekyll-paginate \
    jekyll-plantuml \
    jekyll-sass \
    jekyll-sass-converter \
    jekyll-sitemap \
    kramdown-parser-gfm \
    nokogiri \
    mail \
    uuidtools \
    redcarpet \
    nuggets \
    pygments.rb \
    w3c_validators \
    trollop \
    html-proofer \
    rubocop \
    rubocop-rspec \
    fontcustom \
    s3_website \
    thor -- \
    --use-system-libraries --no-ri --no-rdoc

# RUN gem install jekyll-related-posts -- --use-system-libraries --no-ri --no-rdoc

# ADD giwww.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/*

EXPOSE 4000
CMD [ "jekyll --help" ]
ENTRYPOINT ["/entrypoint"]