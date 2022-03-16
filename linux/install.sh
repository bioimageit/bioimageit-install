#!/bin/bash

install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh -O "$installdir/miniconda3/miniconda.sh"
    bash $installdir/miniconda3/miniconda.sh -b -u -p $installdir/miniconda3
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

    #git clone --depth 1 --branch v0.0.2 https://github.com/bioimageit/bioimageit_formats.git
    #git clone https://github.com/bioimageit/bioimageit_core.git --depth 1 --branch v0.0.2
    #git clone https://github.com/bioimageit/bioimageit_gui.git --depth 1 --branch v0.0.2
    #git clone https://github.com/bioimageit/bioimageit_viewer.git --depth 1 --branch v0.0.2
    #git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    #git clone https://github.com/bioimageit/bioimageit-package.git

	wget https://github.com/bioimageit/bioimageit_framework/archive/refs/heads/main.zip
    unzip ./main.unzip
    rm ./main.zip
    mv ./bioimageit_framework-0.0.2 ./bioimageit_framework

    wget https://github.com/bioimageit/bioimageit-package/archive/refs/heads/main.zip
	unzip ./main.zip
	rm ./main.zip
	mv ./bioimageit-package-main ./bioimageit-package
	
	wget https://github.com/bioimageit/bioimageit_formats/archive/refs/tags/v0.0.2.zip
	unzip ./v0.0.2.zip
	rm ./v0.0.2.zip
	mv ./bioimageit_formats-0.0.2 ./bioimageit_formats
	
	wget https://github.com/bioimageit/bioimageit_core/archive/refs/tags/v0.0.2.zip
	unzip ./v0.0.2.zip
	rm ./v0.0.2.zip
	mv ./bioimageit_core-0.0.2 ./bioimageit_core
	
	wget https://github.com/bioimageit/bioimageit_gui/archive/refs/tags/v0.0.2.zip
	unzip ./v0.0.2.zip
	rm ./v0.0.2.zip
	mv ./bioimageit_gui-0.0.2 ./bioimageit_gui
	
	wget https://github.com/bioimageit/bioimageit_viewer/archive/refs/tags/v0.0.2.zip
	unzip ./v0.0.2.zip
	rm ./v0.0.2.zip
	mv ./bioimageit_viewer-0.0.2 ./bioimageit_viewer
	
	wget https://github.com/bioimageit/bioimageit-toolboxes/archive/refs/heads/main.zip
	unzip ./main.zip
	rm ./main.zip
	mv ./bioimageit-toolboxes-main ./bioimageit-toolboxes
    
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


# install git
$conda_bin install git -y
$conda_bin install -c conda-forge pyside2 -y
$conda_bin install qt -y

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
