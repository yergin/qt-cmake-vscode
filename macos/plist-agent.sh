#!/bin/bash

##
##  plist-agent.sh
##  qt-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

##
## References:
## - https://www.codingforentrepreneurs.com/blog/create-icns-icons-for-macos-apps/
##

/usr/libexec/PlistBuddy -c "Add :LSUIElement bool true" $1