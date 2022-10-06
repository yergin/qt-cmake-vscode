/**
 *  main.cpp
 *  qt-cmake-vscode
 *
 *  Created by Gino Bollaert on 04/10/2022.
 */

#include "MainWindow.h"

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    MainWindow mainWindow;
    mainWindow.show();
    return app.exec();
}
