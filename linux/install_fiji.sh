#!/bin/bash

backend="CONDA"

# setup usefull path
userdir="/home/$USER"

installdir="$userdir/BioImageIT"
conda_bin="$installdir/miniconda3/condabin/conda"
conda_sh="$installdir/miniconda3/etc/profile.d/conda.sh"
python_path="$installdir/miniconda3/bin/python"
pip_path="$installdir/miniconda3/bin/pip"



###################### FIJI ###########################
# create log file
exec >$installdir/install.log 2>&1

cd $installdir

wget https://downloads.imagej.net/fiji/latest/fiji-linux64.zip
unzip fiji-linux64.zip
rm fiji-linux64.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros
