#!/bin/sh
VERSION=3.5.1
PACKAGE=cmake-$VERSION
if [ ! -f /tmp/$PACKAGE-installed ]; then
    curl -L --progress-bar --insecure https://cmake.org/files/v3.5/$PACKAGE.tar.gz --output /tmp/$PACKAGE.tar.gz
    tar xf /tmp/$PACKAGE.tar.gz --directory /tmp
    cd /tmp/$PACKAGE
    ./configure
    make
    make install
    cd ~/
    rm -rf /tmp/$PACKAGE*
    touch /tmp/$PACKAGE-installed
fi
