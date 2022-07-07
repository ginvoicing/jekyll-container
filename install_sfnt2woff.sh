#!/bin/ash

curl -L --progress-bar --insecure http://img.teamed.io/woff-code-latest.zip --output /tmp/woff-code-latest.zip
unzip -d /tmp/sfnt2woff /tmp/woff-code-latest.zip && rm /tmp/woff-code-latest.zip
cd /tmp/sfnt2woff
make
mv sfnt2woff /usr/bin/
chmod +x /usr/bin/sfnt2woff
cd ..
rm -rf /tmp/sfnt2woff