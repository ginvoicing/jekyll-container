#!/bin/ash
VERSION=3.22.5
arch=$(uname -m);
PACKAGE="cmake-${VERSION}-linux-${ARCH}.tar.gz";
case "$arch" in 
    'amd64')
        ARCH="x86_64";
        ;;
    'arm64')
        ARCH="aarch64";
        ;;
    'aarch64')
        ARCH="aarch64";
        ;;
    *) echo >&2 "error: unsupported architecture: '$arch'"; exit 1 ;;
esac;

curl -L --progress-bar --insecure https://github.com/Kitware/CMake/releases/download/v${VERSION}/$PACKAGE --output /tmp/$PACKAGE
tar xf /tmp/$PACKAGE --directory /tmp
cd /tmp/$PACKAGE
./configure
make
make install
cd ~/
rm -rf /tmp/$PACKAGE*
