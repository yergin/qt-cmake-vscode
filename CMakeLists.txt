##
##  CMakeLists.txt
##  qt6-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

cmake_minimum_required(VERSION 3.24)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(AppInfo)

string(REPLACE " " "_" PROJ_NAME ${APP_NAME})
project(${PROJ_NAME} VERSION ${APP_VERSION})
set(TARGET_NAME ${PROJ_NAME})
if (NOT PROJECT_VERSION_PATCH)
    set(PROJECT_VERSION_PATCH 0)
endif()
if (NOT PROJECT_VERSION_TWEAK)
    set(PROJECT_VERSION_TWEAK 0)
endif()

set(CMAKE_OSX_ARCHITECTURES arm64 x86_64)
set(CMAKE_OSX_DEPLOYMENT_TARGET "10.15")
set(CMAKE_CXX_STANDARD 17)
set(CMAKE_CXX_STANDARD_REQUIRED ON)

if (APPLE)
    set(QT6_DIR ~/Qt/6.4.0/macos)
    set(ICON_FILE resources/${ICON_NAME}.icns)
    set_source_files_properties(${ICON_FILE} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set(MACOSX_BUNDLE_BUNDLE_NAME ${APP_NAME})
    set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_LONG_VERSION_STRING ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_COPYRIGHT ${COPYRIGHT})
    set(MACOSX_BUNDLE_GUI_IDENTIFIER ${IDENTIFIER})
    set(MACOSX_BUNDLE_ICON_FILE ${ICON_NAME})
    set(RESOURCE_FILES
        resources/resources.qrc
        resources/${ICON_NAME}.icns
    )
elseif (WIN32)
    set(QT6_DIR c:/Qt/6.4.0/mingw_64)
    enable_language(RC)
    set(ICON_FILE resources/${ICON_NAME})
    configure_file(${PROJECT_SOURCE_DIR}/windows/resources.rc.in resources.rc @ONLY)
    set(RESOURCE_FILES
        resources/resources.qrc
        resources.rc
    )
endif()

set(CMAKE_PREFIX_PATH ${QT6_DIR})
set(CMAKE_INCLUDE_CURRENT_DIR ON)
find_package(Qt6 REQUIRED COMPONENTS ${QT_COMPONENTS})
include_directories(${QT6_DIR}/lib)

qt_standard_project_setup()
set(CMAKE_AUTORCC ON)

add_executable(${TARGET_NAME} ${SOURCE_FILES} ${RESOURCE_FILES})
foreach(LIB ${QT_COMPONENTS})
    target_link_libraries(${TARGET_NAME} PRIVATE Qt6::${LIB})
endforeach(LIB)

set_target_properties(${TARGET_NAME} PROPERTIES
    WIN32_EXECUTABLE ON
    MACOSX_BUNDLE ON
)

if (APPLE)
    if (IS_AGENT)
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND /bin/bash ${CMAKE_CURRENT_SOURCE_DIR}/macos/plist-agent.sh ${CMAKE_CURRENT_SOURCE_DIR}/build/${TARGET_NAME}.app/Contents/Info.plist
        )
    endif()
elseif(WIN32)
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${QT6_DIR}/bin/windeployqt.exe ${CMAKE_CURRENT_SOURCE_DIR}/build/${TARGET_NAME}.exe
    )
endif()