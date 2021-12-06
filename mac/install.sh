#!/bin/bash

install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    curl -o "$installdir/miniconda3/miniconda.sh" https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash "$installdir/miniconda3/miniconda.sh" -b -u -p "$installdir/miniconda3/"
    rm -rf $installdir/miniconda3/miniconda.sh

    chmod +x "$installdir/miniconda3/etc/profile.d/conda.sh"
    "$installdir/miniconda3/etc/profile.d/conda.sh" upgrade conda -y
    "$installdir/miniconda3/etc/profile.d/conda.sh" config --add channels conda-forge
    "$installdir/miniconda3/etc/profile.d/conda.sh" config --add channels bioimageit
}   

setup_bioimageit(){
    in_destination_dir=$1
    python_path=$2
    pip_path=$3
    in_username=$4
    in_backend=$5

    cd $in_destination_dir 

    git clone https://github.com/bioimageit/bioimageit_formats.git
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

    # create shortcuts
    cp bioimageit-package/mac/BioImageIT.sh BioImageIT.sh
    cp bioimageit-package/mac/BioImageIT.sh BioImageIT.command
    cp bioimageit-package/mac/BioImageIT-Browser.sh BioImageIT-Browser.sh
    cp bioimageit-package/mac/BioImageIT-Toolboxes.sh BioImageIT-Toolboxes.sh
    cp bioimageit-package/mac/jupyter.sh jupyter.sh
    cp bioimageit-package/mac/BioImageIT-Runner.sh BioImageIT-Runner.sh
    cp bioimageit-package/mac/BioImageIT-Viewer.sh BioImageIT-Viewer.sh

    chmod +x BioImageIT.sh
    chmod +x BioImageIT-Browser.sh
    chmod +x BioImageIT-Toolboxes.sh
    chmod +x jupyter.sh
    chmod +x BioImageIT-Runner.sh
    chmod +x BioImageIT-Viewer.sh

    # userdata
    mkdir workspace

    # install and config packages
    $pip_path install ./bioimageit_formats
    $pip_path install ./bioimageit_core
    $pip_path install ./bioimageit_gui
    $pip_path install ./bioimageit_viewer
    $pip_path install jupyter
    $python_path bioimageit_core/config.py "${in_username}" "${in_backend}"
    $python_path bioimageit_gui/config.py 
}

######################## MAIN #######################
backend="CONDA"

# setup usefull path
userdir="/Users/$USER"

installdir="$userdir/BioImageIT"
conda_bin="$installdir/miniconda3/condabin/conda"
conda_sh="$installdir/miniconda3/etc/profile.d/conda.sh"
python_path="$installdir/miniconda3/envs/bioimageit/bin/python"
pip_path="$installdir/miniconda3/envs/bioimageit/bin/pip"

# create the install directory
cd $userdir
mkdir -p "$installdir"
cd "$installdir"

# install Local Miniconda
install_miniconda $installdir

# create bioimageit env
$conda_bin create -y --name bioimageit python=3.9

# clone and setup BioImageIT
setup_bioimageit $installdir $python_path $pip_path $USER "CONDA" 


###################### FIJI ###########################
cd $installdir

curl https://downloads.imagej.net/fiji/latest/fiji-macosx.zip -o Fiji.zip
unzip Fiji.zip
rm Fiji.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros

