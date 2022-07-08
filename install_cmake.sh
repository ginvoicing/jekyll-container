#!/bin/ash
VERSION=3.22.5
PACKAGE="cmake-${VERSION}.tar.gz";
curl -L --progress-bar --insecure https://github.com/Kitware/CMake/releases/download/v${VERSION}/${PACKAGE} --output /tmp/${PACKAGE}
tar xf /tmp/$PACKAGE --directory /tmp
cd /tmp/${PACKAGE}
./configure
make
make install
cd ~/
rm -rf /tmp/${PACKAGE}*
