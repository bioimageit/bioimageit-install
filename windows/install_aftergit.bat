set in_destination_dir="."
set in_backend="CONDA_DOCKER"

REM check inputs
echo "destination dir:" %in_destination_dir%
echo "backend:" %in_backend%


cd %in_destination_dir%
rem %python_path% -m venv .bioimageit-env
rem call .bioimageit-env\Scripts\activate

git clone https://github.com/bioimageit/bioimageit_core.git
git clone https://github.com/bioimageit/bioimageit_gui.git
git clone https://github.com/bioimageit/bioimageit_viewer.git
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git

REM create toolboxes database
mkdir toolboxes
mkdir toolboxes\thumbs\
copy .\bioimageit-toolboxes\thumbs\ .\toolboxes\thumbs\
copy .\bioimageit-toolboxes\toolboxes.json .\toolboxes\toolboxes.json
copy .\bioimageit-toolboxes\tools.json .\toolboxes\tools.json
copy .\bioimageit-toolboxes\formats.json .\formats.json
REM rd /s /q .\bioimageit-toolboxes

REM create shortcuts
copy .\bioimageit-package\windows\data_management.bat .\data_management.bat
copy .\bioimageit-package\windows\data_processing.bat .\data_processing.bat
copy .\bioimageit-package\windows\jupyter.bat .\jupyter.bat
copy .\bioimageit-package\windows\runnerapp.bat .\runnerapp.bat
copy .\bioimageit-package\windows\viewer.bat .\viewer.bat


REM userdata
mkdir userdata

REM install and config packages
pip install .\bioimageit_core
pip install .\bioimageit_gui
pip install .\bioimageit_viewer
python bioimageit_core\config.py "%USERNAME%" %in_backend%
python bioimageit_gui\config.py 
