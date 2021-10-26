#!/bin/bash

install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    curl -o "$installdir/miniconda3/miniconda.sh" https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    #wget https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh -O "$installdir/miniconda3/miniconda.sh"
    bash "$installdir/miniconda3/miniconda.sh" -b -u -p "$installdir/miniconda3/"
    rm -rf $installdir/miniconda3/miniconda.sh
    #$installdir/miniconda3/bin/conda init bash
    #$installdir/miniconda3/bin/conda init zsh
}   

setup_bioimageit(){
    in_destination_dir=$1
    python_path=$2
    pip_path=$3
    in_username=$4
    in_backend=$5

    cd $in_destination_dir

    git clone https://github.com/bioimageit/bioimageit_core.git
    git clone https://github.com/bioimageit/bioimageit_gui.git
    git clone https://github.com/bioimageit/bioimageit_viewer.git
    git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    git clone https://github.com/bioimageit/bioimageit-package.git

    # create toolboxes database
    mkdir toolboxes
    mkdir toolboxes/thumbs/
    cp -r bioimageit-toolboxes/thumbs toolboxes/
    cp bioimageit-toolboxes/toolboxes.json toolboxes/toolboxes.json
    cp bioimageit-toolboxes/tools.json toolboxes/tools.json
    cp bioimageit-toolboxes/formats.json ./formats.json
    # rm -rf ./bioimageit-toolboxes

    # create shortcuts
    cp bioimageit-package/mac/data_management.sh data_management.sh
    cp bioimageit-package/mac/data_processing.sh data_processing.sh
    cp bioimageit-package/mac/jupyter.sh jupyter.sh
    cp bioimageit-package/mac/runnerapp.sh runnerapp.sh
    cp bioimageit-package/mac/viewer.sh viewer.sh

    chmod +x data_management.sh
    chmod +x data_processing.sh
    chmod +x jupyter.sh
    chmod +x runnerapp.sh
    chmod +x viewer.sh

    # userdata
    mkdir userdata

    # install and config packages
    $pip_path install ./bioimageit_core
    $pip_path install ./bioimageit_gui
    $pip_path install ./bioimageit_viewer
    $python_path bioimageit_core/config.py "${in_username}" "${in_backend}"
    $python_path bioimageit_gui/config.py 
}

create_app_contents(){
    installdir=$1

    mkdir -p "$installdir/Contents/MacOS";
    cp "$installdir/bioimageit-package/mac/Info.plist" "$installdir/Contents/Info.plist"
    cp "$installdir/data_management.sh" "$installdir/Contents/MacOS/BioimageIT"
    chmod +x "$installdir/Contents/MacOS/BioimageIT"
}

######################## MAIN #######################
backend="CONDA"

# setup usefull path
userdir="/Users/$USER"

#installdir=/Applications/BioimageIT.app
installdir="$userdir/BioimageIT"
conda_path="$installdir/miniconda3/condabin/conda"
python_path="$installdir/miniconda3/envs/bioimageit/bin/python"
pip_path="$installdir/miniconda3/envs/bioimageit/bin/pip"

chmod +x "$installdir/miniconda3/etc/profile.d/conda.sh"

# create the install directory
cd $userdir
mkdir -p "$installdir"
cd "$installdir"

# install Local Miniconda
install_miniconda $installdir

# create bioimageit env
$conda_path create -y --name bioimageit python=3.9

# clone and setup BioImageIT
setup_bioimageit $installdir $python_path $pip_path $USER "CONDA" 

# create the Mac app directory
create_app_contents $installdir
