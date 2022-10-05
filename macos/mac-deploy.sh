#!/bin/bash

##
##  mac-deploy.sh
##  qt6-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

~/Qt/6.4.0/macos/bin/macdeployqt $1
ln -s ./Frameworks $1/Contents/lib