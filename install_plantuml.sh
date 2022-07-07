#!/bin/sh
VERSION=7707-1_all
PACKAGE=plantuml-$VERSION
if [ ! -f /tmp/$PACKAGE-installed ]; then
    curl -L --progress-bar --insecure http://yar.fruct.org/attachments/download/362/plantuml_7707-1_all.deb --output /tmp/$PACKAGE.deb
    dpkg -i /tmp/$PACKAGE.deb
    rm -rf /tmp/$PACKAGE.deb
    touch /tmp/$PACKAGE-installed
fi