/// \file biInstallModel.h
/// \brief biInstallModel
/// \author Sylvain Prigent
/// \version 0.1
/// \date 2020
///
/// Copyright (C) BioImageIT 2020

#pragma once

#include <QtCore>

/// \class biInstallModel
/// \brief Model that run the install commands
class biInstallModel : public QObject
{

public:
    /// \fn biInstallModel()
    /// \brief Constructor
    biInstallModel();

    /// \fn ~biInstallModel()
    /// \brief Destructor
    ~biInstallModel();

public:
    /// \fn void checkCondaInstall(const QString& condaDir);
    /// \brief Check if the consa install is working
    /// throw an exeption if not install correctly
    /// \param[in] condaDir Path to the conda directory
    void checkCondaInstall(const QString& condaDir);

    /// \fn void componentsInstall(const QString& destinationDir, const QString& username);
    /// \brief Install the BioImageIT packages and download client scripts
    /// throw an exeption if an error accure
    /// \param[in] destinationDir Path where the BioImageIT client is installed
    /// \param[in] username Path Name of the person using the client (for metadata)
    void componentsInstall(const QString& destinationDir, const QString& username);

    /// \fn void componentsInstall(const QString& destinationDir, const QString& username);
    /// \brief Install the BioImageIT packages and download client scripts
    /// throw an exeption if an error accure
    /// \param[in] destinationDir Path where the BioImageIT client is installed
    /// \param[in] backend Name of the backend runner (Local, Docker, Singularity, Allgo...)
    void configure(const QString& destinationDir, const QString& backend);

};
