#!/bin/bash

BASEDIR=$(dirname $0)
cd $BASEDIR

# check inputs
if [ -z "$1" ]; then
    read -p "Conda directory: "  in_conda_dir
else
    in_conda_dir="$1"
fi 
check_conda
if [ -z "$2" ]; then
    read -p "Destination directory: "  in_destination_dir
else
    in_destination_dir="$2"
fi    
check_destination $in_destination_dir
if [ -z "$3" ]; then
    read -p "User name: "  in_username
else
    in_username="$3"
fi 
if [ -z "$4" ]; then
    read -p "Backend (Local, Docker, Singularity, Allgo)"  in_backend
else
    in_backend="$4"
fi 
check_backend $in_backend
create_conda_env $in_conda_dir


echo "destination dir: $in_destination_dir"
echo "username: $in_username"
echo "backend: $in_backend"



check_conda(){
    if ! command -v conda -h &> /dev/null
    then
        echo "COMMAND conda could not be found. You need to install conda before installing BioImageIT"
        exit 1
    else
        echo "Conda found !"    
    fi
}

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

create_conda_env(){
    compt = 0
    while [ -d "$1/bioimageit$compt" ]; do
        $compt=$compt+1
    done
    conda create --name "$1/bioimageit$compt"
    conda activate "bioimageit$compt"
    conda install -c bioimageit biomiageit_core
    conda install -c bioimageit bioimageit_gui
    python bioimagepy/config.py "${2}" # this command should be not good
    python bioimageapp/config.py # this command should be not good
}
