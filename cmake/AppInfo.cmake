##
##  AppInfo.cmake
##  qt-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

set(APP_NAME "Template")
set(APP_VERSION 0.1.0)
set(COMPANY Company)
set(IDENTIFIER com.company.qt-template)
set(COPYRIGHT "Copyright (c) 2022 Gino Bollaert. All rights reserved.")
set(ICON_NAME melodica)
set(MACOSX_IS_AGENT FALSE)

set(SOURCE_FILES
    src/main.cpp
    src/MainWindow.cpp
)

set(QT_COMPONENTS Widgets Gui Core)
