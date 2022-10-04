/**
 *  main.cpp
 *  qt6-cmake-vscode
 *
 *  Created by Gino Bollaert on 04/10/2022.
 */

#include <QtWidgets>

int main(int argc, char **argv)
{
    QApplication app(argc, argv);
    QMainWindow mainWindow;
    mainWindow.show();
    return app.exec();
}