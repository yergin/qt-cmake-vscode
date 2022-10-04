#!/bin/bash

##
##  make-icns.sh
##  qt6-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

##
## References:
## - https://www.codingforentrepreneurs.com/blog/create-icns-icons-for-macos-apps/
##

ICON=$1
ICON_SET=$1.iconset

mkdir $ICON_SET

sips -z 16 16 $ICON --out "${ICON_SET}/icon_16x16.png"
sips -z 32 32 $ICON --out "${ICON_SET}/icon_16x16@2x.png"
sips -z 32 32 $ICON --out "${ICON_SET}/icon_32x32.png"
sips -z 64 64 $ICON --out "${ICON_SET}/icon_32x32@2x.png"
sips -z 128 128 $ICON --out "${ICON_SET}/icon_128x128.png"
sips -z 256 256 $ICON --out "${ICON_SET}/icon_128x128@2x.png"
sips -z 256 256 $ICON --out "${ICON_SET}/icon_256x256.png"
sips -z 512 512 $ICON --out "${ICON_SET}/icon_256x256@2x.png"
sips -z 512 512 $ICON --out "${ICON_SET}/icon_512x512.png"

iconutil -c icns $ICON_SET
rm -R $ICON_SET