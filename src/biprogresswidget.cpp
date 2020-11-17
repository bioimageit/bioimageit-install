/// \file biprogresswidget.cpp
/// \brief biProgressWidget
/// \author Sylvain Prigent
/// \version 0.1
/// \date 2020
///
/// Copyright (C) BioImageIT 2020

#include "biprogresswidget.h"

biProgressWidget::biProgressWidget(QWidget *parent) : QWidget(parent)
{

    QVBoxLayout* layout = new QVBoxLayout();
    this->setLayout(layout);

    QProgressBar *progressBar = new QProgressBar(this);
    QLabel* progressLabel = new QLabel(this);
    m_detailsToogle = new QPushButton(tr("More details"), this);
    m_detailsToogle->setObjectName("btnDefault");
    m_detailsToogle->setCheckable(true);
    m_detailsToogle->setChecked(false);
    m_proressEdit = new QTextEdit(this);
    m_proressEdit->setVisible(false);

    layout->addWidget(progressBar);
    layout->addWidget(progressLabel);
    layout->addWidget(m_detailsToogle);
    layout->addWidget(m_proressEdit);

    connect(m_detailsToogle, SIGNAL(released()), this, SLOT(toggleDetails()));
}

void biProgressWidget::toggleDetails()
{
    if (m_detailsToogle->isChecked()){
        m_proressEdit->setVisible(true);
    }
    else{
         m_proressEdit->setVisible(false);
    }
}
