#!/bin/bash

##
##  png2ico.sh
##  qt-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

##
## References:
## - https://www.codingforentrepreneurs.com/blog/create-icns-icons-for-macos-apps/
##

INPUT=$1
BASEPATH="${INPUT%.*}"
EXTENSION="${INPUT##*.}"
if [ $EXTENSION != "png" ] && [ $EXTENSION != "PNG" ]; then
    sips -s format png "$INPUT" --out "$BASEPATH.temp.png"
    INPUT="$BASEPATH.temp.png"
fi
ICON_SET=${BASEPATH}.iconset
mkdir "$ICON_SET"
sips -z 16 16 "$INPUT" --out "$ICON_SET/icon_16x16.png"
sips -z 32 32 "$INPUT" --out "$ICON_SET/icon_16x16@2x.png"
sips -z 32 32 "$INPUT" --out "$ICON_SET/icon_32x32.png"
sips -z 64 64 "$INPUT" --out "$ICON_SET/icon_32x32@2x.png"
sips -z 128 128 "$INPUT" --out "$ICON_SET/icon_128x128.png"
sips -z 256 256 "$INPUT" --out "$ICON_SET/icon_128x128@2x.png"
sips -z 256 256 "$INPUT" --out "$ICON_SET/icon_256x256.png"
sips -z 512 512 "$INPUT" --out "$ICON_SET/icon_256x256@2x.png"
sips -z 512 512 "$INPUT" --out "$ICON_SET/icon_512x512.png"
iconutil -c icns "$ICON_SET"
[ -f "$BASEPATH.ico" ] || sips -s format ico "$ICON_SET/icon_256x256.$EXTENSION" --out "$BASEPATH.ico"
rm -f "$BASEPATH.temp.png"
rm -R "$ICON_SET"
