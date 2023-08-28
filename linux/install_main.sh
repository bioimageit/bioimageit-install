#!/bin/bash
. ./install.conf

install_miniconda(){

    mkdir $installdir/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$installdir/miniconda3/miniconda.sh"
    bash $installdir/miniconda3/miniconda.sh -b -u -p $installdir/miniconda3
    rm -rf $installdir/miniconda3/miniconda.sh

    chmod +x "$conda_sh"
    . "$conda_sh" && conda upgrade conda -y
    . "$conda_sh" && conda config --add channels conda-forge
    . "$conda_sh" && conda config --add channels bioimageit
}   

setup_bioimageit(){
    in_username=$1
    in_backend=$2

    # main app
    cd $installdir
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_framework.git --branch v0.1.3
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_core.git --branch v0.1.3
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_gui.git --branch v0.1.3
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_formats.git --branch v0.1.3
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_viewer.git --branch v0.1.3
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-tools.git
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-package.git
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-notebooks.git
   
    # plugins
    . "$conda_sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-omero.git --branch v0.1.3

    # create toolboxes database
    mkdir toolboxes
    mkdir toolboxes/thumbs/
    cp -r bioimageit-toolboxes/thumbs toolboxes/
    cp bioimageit-toolboxes/toolboxes.json toolboxes/toolboxes.json
    cp bioimageit-toolboxes/tools.json toolboxes/tools.json
    cp bioimageit-toolboxes/formats.json ./formats.json

    # create shortcuts
    cp bioimageit-package/linux/BioImageIT.sh BioImageIT.sh
    cp bioimageit-package/linux/jupyter.sh jupyter.sh

    chmod +x BioImageIT.sh
    chmod +x jupyter.sh

    # userdata
    mkdir workspace
    mkdir workspace/logs

    # install and config packages
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_formats
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_framework
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_core
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_gui
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_viewer
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit-omero
    . "$conda_sh" && conda activate bioimageit && pip install jupyter
    . "$conda_sh" && conda activate bioimageit && python ./bioimageit_core/config.py "${in_username}" "${in_backend}"
    . "$conda_sh" && conda activate bioimageit && python ./bioimageit_gui/config.py 
}

######################## MAIN #######################

# create the install directory
cd $userdir
mkdir -p "$installdir"
cd "$installdir"

# create log file
exec >$installdir/install.log 2>&1

# install Local Miniconda
install_miniconda

# create bioimageit env
. "$conda_sh" && conda create -y --name bioimageit python=3.9
. "$conda_sh" && conda activate bioimageit && conda install -y -c ome omero-py

# install git
. "$conda_sh" && conda install git -y
. "$conda_sh" && conda install -c ome omero-py -y
. "$conda_sh" && conda install -c conda-forge pyside2 -y
#. "$conda_sh" && conda install -c conda-forge qt -y
. "$conda_sh" && conda install -y -c conda-forge gitpython

# clone and setup BioImageIT
setup_bioimageit $USER $backend 

