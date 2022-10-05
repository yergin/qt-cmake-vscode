Qt6/CMake app template for VSCode
=================================

This is intended as a template for developing cross-platform Qt apps under LGPL in VSCode rather than using QtCreator. Supported platforms for deployment are macOS 10.15+ and Windows 10 and above. Linux deployment is not currently supported.

Requirements
------------

* Windows 10 and macOS 12+ (macOS 10.15 is sufficient if deploying the app is not required)
* Qt6 (L)GPL
* CMake 3.22
* VSCode with CMake Tools (Microsoft) extension installed

Windows setup
-------------

Add Qt's MinGW binaries to the system's PATH environment variable. E.g:

`C:\Qt\Tools\mingw1120_64\bin`

Mac setup
---------

No setting up required.

Build instructions
------------------

1. Open VSCode and select "Open Folder..." from the file menu.
2. Select the root folder of this repo.
3. Respond with 'Yes' to configuring the project with CMake.
4. Edit the Qt6 path in `cmake/Qt.cmake` if required.
5. Click on the Tools (Kit) icon in the status bar to select the CMake compiler:
    * Clang on macOS
    * MinGW on Windows
6. Press 'Build' or the play button in the status bar.

Deployment
----------

1. Select the 'Release' build variant in the status bar.
2. Click on \[Template\] to change the target to 'install'
3. Press 'Build' in the status bar.

The `build/dist` folder will contain the distributable app.