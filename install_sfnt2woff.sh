#!/bin/sh
if [ ! -f /tmp/sfnt2woff-installed ]; then
curl -L --progress-bar --insecure http://img.teamed.io/woff-code-latest.zip --output /tmp/woff-code-latest.zip
unzip -d /tmp/sfnt2woff /tmp/woff-code-latest.zip && rm /tmp/woff-code-latest.zip
cd /tmp/sfnt2woff
make
mv sfnt2woff /usr/local/bin/
cd ..
rm -rf /tmp/sfnt2woff
touch /tmp/sfnt2woff-installed
fi