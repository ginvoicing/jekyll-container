#!/bin/ash
VERSION=3.23.2
PACKAGE="cmake-${VERSION}";
curl -L --progress-bar --insecure https://github.com/Kitware/CMake/releases/download/v${VERSION}/${PACKAGE}.tar.gz --output /tmp/${VERSION}
tar xf /tmp/${PACKAGE} --directory /tmp
cd /tmp/${PACKAGE}
./configure
make
make install
cd ~/
rm -rf /tmp/${PACKAGE}*
