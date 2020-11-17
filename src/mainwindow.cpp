#include "mainwindow.h"

#include "biinstallmodel.h"
#include "biinstallwidget.h"
#include "biprogresswidget.h"

MainWindow::MainWindow(QWidget *parent)
    : QWidget(parent)
{

    QVBoxLayout* layout = new QVBoxLayout();
    this->setLayout(layout);

    // header
    QLabel* headerLabel = new QLabel("BioImageIT install", this);
    layout->addWidget(headerLabel);

    // central area
    biInstallWidget* widget = new biInstallWidget(this);
    layout->addWidget(widget);

    // footer widget
    biProgressWidget *footerWidget = new biProgressWidget(this);
    layout->addWidget(footerWidget);

    // model
    biInstallModel* model = new biInstallModel();
}

MainWindow::~MainWindow()
{
}

