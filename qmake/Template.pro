##
##  Template.pro
##  qt6-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

QT += widgets

CONFIG += c++17

SOURCES += ../src/main.cpp

@
win32 {
    RC_ICONS = ../resources/melodica.ico
}
macx {
    ICON = ../resources/melodica.ico.icns
}
@
