/// \file biInstallWidget.h
/// \brief biInstallWidget
/// \author Sylvain Prigent
/// \version 0.1
/// \date 2020
///
/// Copyright (C) BioImageIT 2020

#pragma once

#include <QtWidgets>

/// \class biInstallWidget
/// \brief Main widget of the install GUI
class biInstallWidget : public QWidget
{

public:
    /// \fn biInstallWidget(QWidget* parent = nullptr)
    /// \brief Constructor
    /// \param[in] widget Parent widget fir Qt memory management
    biInstallWidget(QWidget* parent = nullptr);

    /// \fn ~biInstallModel()
    /// \brief Destructor
    ~biInstallWidget();

protected:
    void createMainWidget();

};
