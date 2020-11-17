/// \file biinstallwidget.cpp
/// \brief biinstallwidget
/// \author Sylvain Prigent
/// \version 0.1
/// \date 2020
///
/// Copyright (C) BioImageIT 2020

#include "biinstallwidget.h"

biInstallWidget::biInstallWidget(QWidget* parent) : QWidget(parent){


    this->createMainWidget();

}

biInstallWidget::~biInstallWidget(){

}

void biInstallWidget::createMainWidget(){

    QGridLayout* layout = new QGridLayout();

    QLabel *condaTitleLabel = new QLabel(tr("Conda directory"), this);
    QLabel *destinationTitleLabel = new QLabel(tr("Destination directory"), this);
    QLabel *usernameTitleLabel = new QLabel(tr("Username"), this);
    QLabel *backendTitleLabel = new QLabel(tr("Backend"), this);

    QLineEdit* condaEdit = new QLineEdit(this);
    QPushButton *condaBrowseButton = new QPushButton("...", this);
    condaBrowseButton->setObjectName("btnDefault");

    QLineEdit* destinationEdit = new QLineEdit(this);
    QPushButton *destinationBrowseButton = new QPushButton("...", this);
    destinationBrowseButton->setObjectName("btnDefault");

    QLineEdit* usernameEdit = new QLineEdit(this);

    QComboBox* backendBox = new QComboBox(this);
    QStringList backendList;
    backendList.append(tr("Local"));
    backendList.append(tr("Docker"));
    backendList.append(tr("Singularity"));
    backendList.append(tr("Allgo"));
    backendBox->addItems(backendList);

    layout->addWidget(condaTitleLabel, 0, 0);
    layout->addWidget(condaEdit, 0, 1);
    layout->addWidget(condaBrowseButton, 0, 2);

    layout->addWidget(destinationTitleLabel, 1, 0);
    layout->addWidget(destinationEdit, 1, 1);
    layout->addWidget(destinationBrowseButton, 1, 2);

    layout->addWidget(usernameTitleLabel, 2, 0);
    layout->addWidget(usernameEdit, 2, 1, 1, 2);

    layout->addWidget(backendTitleLabel, 3, 0);
    layout->addWidget(backendBox, 3, 1, 1, 2);

    this->setLayout(layout);
}
