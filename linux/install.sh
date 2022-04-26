#!/bin/bash

install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$installdir/miniconda3/miniconda.sh"
    bash $installdir/miniconda3/miniconda.sh -b -u -p $installdir/miniconda3
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

    # main app
    cd $in_destination_dir
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_framework.git --branch v0.1.1
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_formats.git --branch v0.1.1
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_core.git --branch v0.1.1
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_gui.git --branch v0.1.1
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit_viewer.git --branch v0.1.1
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-tools.git
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-package.git
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-notebooks.git
   
    # plugins
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && git clone https://github.com/bioimageit/bioimageit-omero.git --branch v0.1.1

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
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_formats
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_framework
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_core
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_gui
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit_viewer
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install ./bioimageit-omero
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && pip install jupyter
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && python ./bioimageit_core/config.py "${in_username}" "${in_backend}"
    . "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && python ./bioimageit_gui/config.py 
}

######################## MAIN #######################
backend="CONDA"

# setup usefull path
userdir="/home/$USER"

installdir="$userdir/BioImageIT"
conda_bin="$installdir/miniconda3/condabin/conda"
conda_sh="$installdir/miniconda3/etc/profile.d/conda.sh"
python_path="$installdir/miniconda3/bin/python"
pip_path="$installdir/miniconda3/bin/pip"

# create the install directory
cd $userdir
mkdir -p "$installdir"
cd "$installdir"

# install Local Miniconda
install_miniconda $installdir

# create bioimageit env
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda create -y --name bioimageit python=3.9
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda activate bioimageit && conda install -y -c ome omero-py

# install git
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda install git -y
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda install -c ome omero-py -y
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda install -c conda-forge pyside2 -y
#. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda install -c conda-forge qt -y
. "$installdir/miniconda3/etc/profile.d/conda.sh" && conda install -y -c conda-forge gitpython

# clone and setup BioImageIT
setup_bioimageit $installdir $python_path $pip_path $USER "CONDA" 




###################### FIJI ###########################
cd $installdir

wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip
rm fiji-linux64.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros

##################### Shortcuts #######################
cd $installdir

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/linux/bioimageit.desktop
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/linux/BioImageIT-Workspace.desktop
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/linux/BioImageIT-Jupyter.desktop
cp  bioimageit.desktop /home/$USER/.local/share/applications/BioImageIT.desktop
cp BioImageIT-Workspace.desktop /home/$USER/.local/share/applications/BioImageIT-Workspace.desktop
cp BioImageIT-Jupyter.desktop /home/$USER/.local/share/applications/BioImageIT-Jupyter.desktop

sed -i 's/$USER/'$USER'/g' /home/$USER/.local/share/applications/BioImageIT.desktop
sed -i 's/$USER/'$USER'/g' /home/$USER/.local/share/applications/BioImageIT-Workspace.desktop
sed -i 's/$USER/'$USER'/g' /home/$USER/.local/share/applications/BioImageIT-Jupyter.desktop

cd $installdir
rm bioimageit.desktop
rm BioImageIT-Workspace.desktop
rm BioImageIT-Jupyter.desktop

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/windows/icon.ico
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/linux/Workspace.ico
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/main/linux/jupyter.ico



##################### Removing useless #######################
cd $installdir
rm -rf ./bioimageit-package
rm -rf ./toolboxes/tools/fiji_utils
rm -rf ./toolboxes/tools/fiji_plugins
