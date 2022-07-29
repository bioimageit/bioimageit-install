######################## MAIN #######################
backend="CONDA"

# setup usefull path
userdir="/home/$USER"

installdir="$userdir/BioImageIT"
conda_bin="$installdir/miniconda3/condabin/conda"
conda_sh="$installdir/miniconda3/etc/profile.d/conda.sh"
python_path="$installdir/miniconda3/bin/python"
pip_path="$installdir/miniconda3/bin/pip"


########## install_main.sh ##########

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/v0.1.2/linux/install_main.sh && chmod +x install_main.sh && sh install_main.sh
echo "25 %"


########## install_fiji.sh ##########

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/v0.1.2/linux/install_fiji.sh && chmod +x install_fiji.sh && sh install_fiji.sh
echo "50 %"


########## install_shortcuts.sh ##########

wget https://raw.githubusercontent.com/bioimageit/bioimageit-install/v0.1.2/linux/install_shortcuts.sh && chmod +x install_shortcuts.sh && sh install_shortcuts.sh
echo "75 %"

########## Remove sh files ##########
cd $userdir

rm install_main.sh
rm install_fiji.sh
rm install_shortcuts.sh

echo "100 %"
echo "BioImageIT is installed."
