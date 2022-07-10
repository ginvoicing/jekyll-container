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
    libc6-compat \
    woff2

RUN set -ex \
    \
    &&  mkdir -p /home/jekyll && \
    addgroup -Sg 1000 jekyll && \
    adduser -SG jekyll -u 1000 -s /bin/sh -h /home/jekyll jekyll && \
    chown jekyll:jekyll /home/jekyll && \
    echo 'jekyll ALL=NOPASSWD:ALL' >> /etc/sudoers && \
    mkdir ${APP_SOURCE} && \
    chown jekyll:jekyll ${APP_SOURCE}

ADD https://github.com/htacg/tidy-html5/archive/refs/tags/5.8.0.tar.gz /tmp/
RUN tar xf /tmp/5.8.0.tar.gz --directory /tmp/ && \
    cd /tmp/tidy-html5-5.8.0/build/cmake && \
    cmake ../.. && \
    make && \
    make install

ADD http://img.teamed.io/woff-code-latest.zip /tmp/
RUN unzip -d /tmp/sfnt2woff /tmp/woff-code-latest.zip && \
    cd /tmp/sfnt2woff && \
    make && \
    mv sfnt2woff /usr/bin/ && \
    chmod +x /usr/bin/sfnt2woff

ADD entrypoint /
RUN chmod +x /entrypoint

ENV JEKYLL_VERSION=4.2.2
# Stops slow Nokogiri!
RUN gem install jekyll -v ${JEKYLL_VERSION} -- --use-system-libraries --no-ri --no-rdoc
RUN gem install \
    rake \
    jekyll-feed \
    jekyll-gist \
    jekyll-paginate \
    jekyll-plantuml \
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


WORKDIR ${APP_SOURCE}
VOLUME  ${APP_SOURCE}
EXPOSE 4000
CMD [ "jekyll --help" ]
ENTRYPOINT ["/entrypoint"]