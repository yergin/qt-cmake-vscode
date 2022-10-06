Qt + CMake cross-platform app template for VSCode
=================================================

This is intended as a template for developing distributable cross-platform Qt apps under LGPL in VSCode rather than using QtCreator. Supported platforms for deployment are macOS 10.15+ and Windows 10 and above. Linux deployment is not currently supported.

A word of warning
-----------------

Simply using this template does not automatically make your app compliant to Qt's LGPL requirements, which you can read about [here](https://www.qt.io/licensing/open-source-lgpl-obligations).

Dev minimum requirements
------------------------

* Windows 10 / macOS 12 (macOS 10.15 is sufficient if deploying the app is not required)
* Qt 6.x (L)GPL for desktop development
* CMake 3.22 or above
* VSCode with CMake Tools (Microsoft) extension installed

Setting up
----------

If you are on Windows, before following the steps below, add Qt's MinGW bin folder to the system's PATH environment variable. For Qt 6.4.0, the MinGW bin folder is located at:

`C:\Qt\Tools\mingw1120_64\bin`

Set up the project in VSCode:

1. Open VSCode and select 'Open Folder...' from the 'File' menu.
2. Select the root folder of this repo.
3. Respond with 'Yes' to configuring the project with CMake.
4. Check the paths in `cmake/Qt.cmake` and change them to match your Qt's installation folder.
5. Click on CMake's Kit icon in the status bar (the one that looks like a spanner) to select the CMake compiler:
    * Clang on macOS
    * MinGW on Windows

You are now ready to build, run or debug the app. After building, the app can be found in the `build` directory, however, this build is unlikely to work on other machines. To distribute the app, follow the steps in the 'Deployment' section below.

Deployment
----------

1. Select the 'Release' build variant in the status bar.
2. Click on \[Template\] to change the default build target to \[install\]
3. Press 'Build' in the status bar.

The `build/dist` folder will contain the distributable app.

Customising the app
-------------------

Set your application name, version, source files and other information in `cmake/AppInfo.cmake`.

To change the application icon, replace the `*.ico` (Windows) and `*.icns` (macOS) files in the `resources` folder, setting `ICON_NAME` to the base file name (without the file extension) in `AppInfo.cmake`. The macOS utility script `macos\png2ico.sh` generates `ICO` and `ICNS` files from a `PNG`, should you need it. There are many online tools which convert uploaded images into icons, such as [this one](https://redketchup.io/icon-converter).

If developing a macOS agent (a.k.a. service or deamon) which must run without a task bar icon, set `MACOSX_IS_AGENT` to `TRUE` in `AppInfo.cmake`.

Resource files who's data is needed at runtime should be placed in the `resources` folder and listed in `resources.qrc`.

Code completion
---------------

To enable code completion in VSCode on macOS, set up the following configuration in `.vscode/c_cpp_properties.json`:
```json
    "configurations": [
        {
            "name": "Mac",
            "includePath": [
                "${workspaceFolder}"
            ],
            "defines": [],
            "macFrameworkPath": ["/Library/Developer/CommandLineTools/SDKs/MacOSX11.3.sdk/System/Library/Frameworks"],
            "compilerPath": "/usr/bin/clang",
            "cStandard": "gnu17",
            "cppStandard": "gnu++17",
            "intelliSenseMode": "${default}",
            "configurationProvider": "ms-vscode.cmake-tools"
        }
    ],
```

Know issues
-----------

* Spaces in the app name are replaced with underscores '_' in order for Qt's deployment tools to work. You'll need to manually rename the application file after deployment if you want to retain the spaces in its name.
* Certain app information such as the company name or copyright does not appear in the Windows executable file properties.