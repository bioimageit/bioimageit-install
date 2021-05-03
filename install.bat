set BASEDIR=%CD%
cd %BASEDIR%


set in_destination_dir="."
set in_username="default"
set in_backend="CONDA_DOCKER"

REM check inputs
echo "destination dir:" %in_destination_dir%
echo "username:" %in_username%
echo "backend:" %in_backend%



cd %in_destination_dir%
python -m venv .bioimageit-env
.bioimageit-env/bin/activate.bat

git clone https://github.com/bioimageit/bioimageit_core.git
git clone https://github.com/bioimageit/bioimageit_gui.git
git clone https://github.com/bioimageit/bioimageit_viewer.git
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git

REM create toolboxes database
mkdir toolboxes
copy -r bioimageit-toolboxes\thumbs toolboxes
copy bioimageit-toolboxes\toolboxes.json toolboxes\toolboxes.json
copy bioimageit-toolboxes\tools.json toolboxes\tools.json
copy bioimageit-toolboxes\formats.json .\formats.json
rd /s /q .\bioimageit-toolboxes

REM create shortcuts
copy bioimageit-package\scripts\data_management.sh .\data_management.bat
copy bioimageit-package\scripts\data_processing.sh .\data_processing.bat
copy bioimageit-package\scripts\jupyter.sh .\jupyter.bat

REM userdata
mkdir userdata

REM install and config packages
pip install .\bioimageit_core
pip install .\bioimageit_gui
pip install .\bioimageit_viewer
python bioimageit_core\config.py %in_username% %in_backend%
python bioimageit_gui\config.py 
