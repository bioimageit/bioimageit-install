#!/bin/bash


install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    curl -o "$installdir/miniconda3/miniconda.sh" https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash "$installdir/miniconda3/miniconda.sh" -b -u -p "$installdir/miniconda3/"
    rm -rf $installdir/miniconda3/miniconda.sh

    chmod +x "$installdir/miniconda3/etc/profile.d/conda.sh"
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda upgrade conda -y
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda config --add channels conda-forge
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda config --add channels bioimageit
}   

setup_bioimageit(){
    in_destination_dir=$1
    python_path=$2
    pip_path=$3
    in_username=$4
    in_backend=$5

    cd $in_destination_dir 

    # main app
    git clone https://github.com/bioimageit/bioimageit_framework.git
    git clone https://github.com/bioimageit/bioimageit_formats.git
    git clone https://github.com/bioimageit/bioimageit_core.git
    git clone https://github.com/bioimageit/bioimageit_gui.git
    git clone https://github.com/bioimageit/bioimageit_viewer.git
    git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    git clone https://github.com/bioimageit/bioimageit-tools.git
    git clone https://github.com/bioimageit/bioimageit-package.git
    git clone https://github.com/bioimageit/bioimageit-notebooks.git

    # plugins
    git clone https://github.com/bioimageit/bioimageit-omero.git

    # create toolboxes database
    mkdir toolboxes
    mkdir toolboxes/thumbs/
    cp -r bioimageit-toolboxes/thumbs toolboxes/
    cp bioimageit-toolboxes/toolboxes.json toolboxes/toolboxes.json
    cp bioimageit-toolboxes/tools.json toolboxes/tools.json
    cp bioimageit-toolboxes/formats.json ./formats.json

    # create shortcuts
    cp bioimageit-package/mac/BioImageIT.sh BioImageIT.sh
    cp bioimageit-package/mac/jupyter.sh jupyter.sh
    cp -r bioimageit-package/mac/BioImageIT.app/ /Applications/BioImageIT.app/
    cp -r "bioimageit-package/mac/BioImageIT Workspace.app/" "/Applications/BioImageIT Workspace.app/"
    cp -r "bioimageit-package/mac/BioImageIT Jupyter.app/" "/Applications/BioImageIT Jupyter.app/"

    chmod +x BioImageIT.sh
    chmod +x jupyter.sh

    # userdata
    mkdir workspace
    mkdir workspace/logs

    # install and config packages
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_formats
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install ./bioimageit_framework
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install ./bioimageit_core
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install ./bioimageit_gui
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install ./bioimageit_viewer
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install ./bioimageit-omero
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip  install jupyter
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && python  bioimageit_core/config.py "${in_username}" "${in_backend}"
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && python bioimageit_gui/config.py 
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

# log
exec >$installdir/installation.log 2>&1

# install Local Miniconda
install_miniconda $installdir

# create bioimageit env
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda create -y --name bioimageit python=3.9
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && conda install -y git
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && conda install -y -c conda-forge gitpython
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && conda install -y -c ome omero-py

# clone and setup BioImageIT
setup_bioimageit $installdir $python_path $pip_path $USER "CONDA" 


###################### FIJI ###########################
cd $installdir

curl https://downloads.imagej.net/fiji/latest/fiji-macosx.zip -o Fiji.zip
unzip Fiji.zip
rm Fiji.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros
