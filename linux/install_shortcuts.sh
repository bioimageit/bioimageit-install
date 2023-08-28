#!/bin/bash
. ./install.conf

##################### Shortcuts #######################
# create log file
exec >$installdir/install.log 2>&1

cd $installdir

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/bioimageit.desktop
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/BioImageIT-Workspace.desktop
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/BioImageIT-Jupyter.desktop

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

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/windows/icon.ico
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/Workspace.ico
wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/$biit_version/linux/jupyter.ico



##################### Removing useless #######################
cd $installdir
rm -rf ./bioimageit-package
rm -rf ./toolboxes/tools/fiji_utils
rm -rf ./toolboxes/tools/fiji_plugins
