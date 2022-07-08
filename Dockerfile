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
    cmake \
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
    npm \
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
    less \
    openssl \
    zlib \
    nodejs \
    yarn \
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


ADD install_cmake.sh /tmp/install_cmake.sh
ADD install_sfnt2woff.sh /tmp/install_sfnt2woff.sh
ADD install_tidy.sh /tmp/install_tidy.sh
ADD entrypoint /


RUN chmod +x /entrypoint

WORKDIR ${APP_SOURCE}
VOLUME  ${APP_SOURCE}

RUN set -ex \
    \
    && /tmp/install_cmake.sh && \
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
    scss_lint \
    html-proofer \
    rubocop \
    rubocop-rspec \
    fontcustom \
    s3_website \
    thor -- \
    --use-system-libraries --no-ri --no-rdoc

# RUN gem install jekyll-related-posts -- --use-system-libraries --no-ri --no-rdoc

# ADD giwww.conf /etc/nginx/conf.d/default.conf

RUN rm -rf /var/cache/apk/* && rm -rf /tmp/install*

EXPOSE 4000
CMD [ "jekyll --help" ]
ENTRYPOINT ["/entrypoint"]