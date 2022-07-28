#!/bin/bash

backend="CONDA"

# setup usefull path
userdir="/home/$USER"

installdir="$userdir/BioImageIT"
conda_bin="$installdir/miniconda3/condabin/conda"
conda_sh="$installdir/miniconda3/etc/profile.d/conda.sh"
python_path="$installdir/miniconda3/bin/python"
pip_path="$installdir/miniconda3/bin/pip"


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
