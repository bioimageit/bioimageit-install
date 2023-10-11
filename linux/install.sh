#!/bin/bash

execution_path=$(pwd)
debug=false
biit_version=v0.2.0

if [ "$debug" = false ]; then
    wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/install.conf
fi

## Source conf file
. ./install.conf


if [ "$debug" = true ]; then
    echo "Debugging. Local install files will be used and they won’t be deleted."
else
    wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/install_main.sh
    wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/install_fiji.sh 
    wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/install_shortcuts.sh 
fi


########## install_main.sh ##########

chmod +x install_main.sh && sh install_main.sh
echo "25 %"

########## install_fiji.sh ##########

chmod +x install_fiji.sh && sh install_fiji.sh
echo "50 %"

########## install_shortcuts.sh ##########


chmod +x install_shortcuts.sh && sh install_shortcuts.sh
echo "75 %"

########## Remove sh files ##########
cd $execution_path

if [ "$debug" = false ]; then
    rm install.conf
    rm install_main.sh
    rm install_fiji.sh
    rm install_shortcuts.sh
fi

echo "100 %"
echo "BioImageIT is installed."
