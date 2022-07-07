#!/bin/ash
VERSION=5.6.0
PACKAGE=tidy-html5-$VERSION
curl -L --progress-bar --insecure https://github.com/htacg/tidy-html5/archive/$VERSION.tar.gz --output /tmp/$PACKAGE.tar.gz
cd /tmp
tar -xvzf /tmp/$PACKAGE.tar.gz
cd /tmp/$PACKAGE/build/cmake
cmake ../..
make
make install
cd ~/
rm -rf /tmp/$PACKAGE*