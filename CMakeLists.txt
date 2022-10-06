##
##  CMakeLists.txt
##  qt-cmake-vscode
##
##  Created by Gino Bollaert on 04/10/2022.
##

cmake_minimum_required(VERSION 3.22)
set(CMAKE_MODULE_PATH ${CMAKE_CURRENT_SOURCE_DIR}/cmake)
include(AppInfo)
include(Qt)

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

if (APPLE)
    set(ICON_FILE resources/${ICON_NAME}.icns)
    set_source_files_properties(${ICON_FILE} PROPERTIES MACOSX_PACKAGE_LOCATION Resources)
    set(MACOSX_BUNDLE_BUNDLE_NAME ${APP_NAME})
    set(MACOSX_BUNDLE_BUNDLE_VERSION ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_LONG_VERSION_STRING ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_SHORT_VERSION_STRING ${PROJECT_VERSION})
    set(MACOSX_BUNDLE_COPYRIGHT ${COPYRIGHT})
    set(MACOSX_BUNDLE_GUI_IDENTIFIER ${IDENTIFIER})
    set(MACOSX_BUNDLE_ICON_FILE ${ICON_NAME}.icns)
    set(RESOURCE_FILES
        resources/resources.qrc
        ${ICON_FILE}
    )
elseif (WIN32)
    enable_language(RC)
    set(ICON_FILE resources/${ICON_NAME}.ico)
    configure_file(${CMAKE_SOURCE_DIR}/windows/resources.rc.in resources.rc @ONLY)
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
    XCODE_ATTRIBUTE_ENABLE_HARDENED_RUNTIME YES
)

set(BUILD_DIR ${PROJECT_SOURCE_DIR}/build)

file(COPY ${QT6_DIR}/../../Licenses/LICENSE DESTINATION ${BUILD_DIR})

if (APPLE)
    if (MACOSX_IS_AGENT)
        add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
            COMMAND /bin/bash ${CMAKE_SOURCE_DIR}/macos/plist-agent.sh ${BUILD_DIR}/${TARGET_NAME}.app/Contents/Info.plist
        )
    endif()
elseif(WIN32)
    # We need the DLLs normally copied during deployment in order to debug in VSCode
    add_custom_command(TARGET ${TARGET_NAME} POST_BUILD
        COMMAND ${QT6_DIR}/bin/windeployqt.exe ${BUILD_DIR}/${TARGET_NAME}.exe
    )
endif()

set(DIST_DIR ${BUILD_DIR}/dist)
set(BUILT_APP ${BUILD_DIR}/${APP_NAME}.app)
set(DIST_APP ${DIST_DIR}/${APP_NAME}.app)
set(CMAKE_INSTALL_PREFIX ${DIST_DIR})

if (APPLE)
    configure_file(${CMAKE_SOURCE_DIR}/macos/notarize.sh.in notarize.sh @ONLY)
    # Qt's deploy script is broken for Mac so run the command-line version instead
    configure_file(${CMAKE_SOURCE_DIR}/macos/mac-deploy.sh.in mac-deploy.sh @ONLY)
    install(SCRIPT ${CMAKE_SOURCE_DIR}/macos/PostInstall.cmake)
elseif(WIN32)
    install(TARGETS ${TARGET_NAME}
        BUNDLE DESTINATION .
        RUNTIME DESTINATION ${CMAKE_INSTALL_BINDIR}
    )
    qt_generate_deploy_app_script(
        TARGET ${TARGET_NAME}
        FILENAME_VARIABLE deploy_script
        NO_UNSUPPORTED_PLATFORM_ERROR
    )
    install(SCRIPT ${deploy_script})
endif()