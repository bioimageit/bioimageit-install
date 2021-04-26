#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

# check inputs
if [ -z "$1" ]; then
    read -p "Destination directory: "  in_destination_dir
else
    in_destination_dir="$1"
fi    
check_destination $in_destination_dir
if [ -z "$2" ]; then
    read -p "User name: "  in_username
else
    in_username="$2"
fi 
if [ -z "$3" ]; then
    read -p "Backend (Local, Docker, Singularity, Allgo)"  in_backend
else
    in_backend="$3"
fi 

echo "destination dir: $in_destination_dir"
echo "username: $in_username"
echo "backend: $in_backend"

check_destination(){
    if [ -d "$1" ]; then
        echo "Destination directory found !"
    else
        mkdir -p "$1"  || { echo 'Unable to create the destination dir' ; exit 1; }  
        echo "Destination directory created !"  
    fi
}

check_backend(){
    if [ "$1" == "Local" ]; then
        echo "Use Local backend"
    elif [ "$1" == "Docker"  ]; then 
        echo "Use Docker backend"
    elif [ "$1" == "Singularity"  ]; then 
        echo "Use Singularity backend"    
    fi
}

intall_bioimageit(){
    in_destination_dir=$1
    in_username=$2
    in_backend=$3

    cd $in_destination_dir
    python -m venv .bioimageit-env
    source .bioimageit-env/bin/activate

    git clone https://github.com/bioimageit/bioimageit_core.git
    git clone https://github.com/bioimageit/bioimageit_gui.git
    git clone https://github.com/bioimageit/bioimageit_viewer.git
    git clone https://github.com/bioimageit/bioimageit-toolboxes.git
    git clone https://github.com/bioimageit/bioimageit-package.git

    # create toolboxes database
    mkdir toolboxes
    cp -r bioimageit-toolboxes/thumbs toolboxes
    cp bioimageit-toolboxes/toolboxes.json toolboxes/toolboxes.json
    cp bioimageit-toolboxes/tools.json toolboxes/tools.json
    cp bioimageit-toolboxes/formats.json ./formats.json
    rm -rf ./bioimageit-toolboxes

    # create shortcuts
    cp bioimageit-package/scripts/data_management.sh ./data_management.sh
    cp bioimageit-package/scripts/data_processing.sh ./data_processing.sh
    cp bioimageit-package/scripts/jupyter.sh ./jupyter.sh


    pip install ./bioimageit_core
    pip install ./bioimageit_gui
    pip install ./bioimageit_viewer
    python bioimageit_core/config.py "${in_username}" "${in_backend}"
    python bioimageit_gui/config.py 
}

check_destination $in_destination_dir
check_backend $in_backend
intall_bioimageit $in_destination_dir $in_username $in_backend
