/**
 *  MainWindow.cpp
 *  qt-cmake-vscode
 *
 *  Created by Gino Bollaert on 06/10/2022.
 */

#include "MainWindow.h"

MainWindow::MainWindow(QWidget* parent)
: QMainWindow(parent)
{
    setWindowTitle("Template App - Qt License");
    setMinimumWidth(400);
    setMinimumHeight(400);
    setContentsMargins(6, 6, 6, 6);

    auto licenseViewer = new QLabel;
    QFile ss(":Qt/LICENSE");
    if (ss.open(QFile::ReadOnly))
    {
        licenseViewer->setText(ss.readAll().data());
    }
    else
    {
        licenseViewer->setText("License missing!");
    }
    licenseViewer->setWordWrap(true);

    auto area = new QScrollArea;
    area->setWidget(licenseViewer);
    area->setWidgetResizable(true);
    setCentralWidget(area);
}
