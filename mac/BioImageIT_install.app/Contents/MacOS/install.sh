#!/bin/bash

. ./install.conf

install_miniconda(){
    installdir=$1

    mkdir $installdir/miniconda3
    curl -o "$installdir/miniconda3/miniconda.sh" https://repo.anaconda.com/miniconda/Miniconda3-latest-MacOSX-x86_64.sh
    bash "$installdir/miniconda3/miniconda.sh" -b -u -p "$installdir/miniconda3/"
    rm -rf $installdir/miniconda3/miniconda.sh

    chmod +x "$conda_sh"
    . "$conda_sh" && conda upgrade conda -y
    . "$conda_sh" && conda config --add channels conda-forge
    . "$conda_sh" && conda config --add channels bioimageit
}   

setup_bioimageit(){
    in_username=$1
    in_backend=$2

    framework_repo=https://github.com/bioimageit/bioimageit_framework.git
    [[ ! -z "$biit_framework_tag" ]] && framework_repo+=" --branch ${biit_framework_tag}"
    
    core_repo=https://github.com/bioimageit/bioimageit_core.git
    [[ ! -z "$biit_core_tag" ]] && core_repo+=" --branch ${biit_core_tag}"
    
    gui_repo=https://github.com/bioimageit/bioimageit_gui.git
    [[ ! -z "$biit_gui_tag" ]] && gui_repo+=" --branch ${bitt_gui_tag}"
    
    formats_repo=https://github.com/bioimageit/bioimageit_formats.git
    [[ ! -z "$biit_formats_tag" ]] && formats_repo+=" --branch ${biit_formats_tag}"
    
    viewer_repo=https://github.com/bioimageit/bioimageit_viewer.git
    [[ ! -z "$biit_viewer_tag" ]] && viewer_repo+=" --branch ${biit_viewer_tag}"
    
    toolboxes_repo=https://github.com/bioimageit/bioimageit-toolboxes.git
    [[ ! -z "$biit_toolboxes_tag" ]] && toolboxes_repo+=" --branch ${biit_toolboxes_tag}"
    
    tools_repo=https://github.com/bioimageit/bioimageit-tools.git
    [[ ! -z "$biit_tools_tag" ]] && tools_repo+=" --branch ${biit_tools_tag}"
    
    package_repo=https://github.com/bioimageit/bioimageit-package.git
    [[ ! -z "$biit_package_tag" ]] && package_repo+=" --branch ${biit_package_tag}"
    
    notebooks_repo=https://github.com/bioimageit/bioimageit-notebooks.git
    [[ ! -z "$biit_notebooks_tag" ]] && notebooks_repo+=" --branch ${biit_notebooks_tag}"
    
    omero_repo=https://github.com/bioimageit/bioimageit-omero.git
    [[ ! -z "$biit_omero_tag" ]] && omero_repo+=" --branch ${biit_omero_tag}"


    # main app
    cd $installdir
    . "$conda_sh" && conda activate bioimageit && git clone $framework_repo
    . "$conda_sh" && conda activate bioimageit && git clone $core_repo
    . "$conda_sh" && conda activate bioimageit && git clone $gui_repo
    . "$conda_sh" && conda activate bioimageit && git clone $formats_repo
    . "$conda_sh" && conda activate bioimageit && git clone $viewer_repo
    . "$conda_sh" && conda activate bioimageit && git clone $toolboxes_repo
    . "$conda_sh" && conda activate bioimageit && git clone $tools_repo
    . "$conda_sh" && conda activate bioimageit && git clone $package_repo
    . "$conda_sh" && conda activate bioimageit && git clone $notebooks_repo
    
    # plugins
    . "$conda_sh" && conda activate bioimageit && git clone $omero_repo

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
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_formats
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_framework
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_core
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_gui
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit_viewer
    . "$conda_sh" && conda activate bioimageit && pip install ./bioimageit-omero
    . "$conda_sh" && conda activate bioimageit && pip install jupyter
    . "$conda_sh" && conda activate bioimageit && python bioimageit_core/config.py "${in_username}" "${in_backend}"
    . "$conda_sh" && conda activate bioimageit && python bioimageit_gui/config.py 
}

######################## MAIN #######################


# create the install directory
userdir="/Users/$USER"
cd $userdir
mkdir -p "$installdir"
cd "$installdir"

# log
exec >$installdir/installation.log 2>&1

# install Local Miniconda
install_miniconda

# create bioimageit env
. "$conda_sh" && conda create -y --name bioimageit python=3.9

# install git
. "$conda_sh" && conda activate bioimageit && conda install -y git
. "$conda_sh" && conda activate bioimageit && conda install -y -c conda-forge gitpython
. "$conda_sh" && conda activate bioimageit && conda install -y -c ome omero-py

# clone and setup BioImageIT
setup_bioimageit $USER $backend


###################### FIJI ###########################
cd $installdir

curl https://downloads.imagej.net/$fiji_version/latest/fiji-macosx.zip -o Fiji.zip
unzip -o Fiji.zip
rm Fiji.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros
