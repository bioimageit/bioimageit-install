set in_destination_dir="."
set in_backend="CONDA"

REM check inputs
echo "destination dir:" %in_destination_dir%
echo "backend:" %in_backend%


cd %in_destination_dir%
rem %python_path% -m venv .bioimageit-env
rem call .bioimageit-env\Scripts\activate

git clone https://github.com/bioimageit/bioimageit_core.git
git clone https://github.com/bioimageit/bioimageit_gui.git
git clone https://github.com/bioimageit/bioimageit_formats.git
git clone https://github.com/bioimageit/bioimageit_viewer.git
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git
git clone https://github.com/bioimageit/bioimageit-install.git

REM create toolboxes database
mkdir toolboxes
mkdir toolboxes\thumbs\
copy .\bioimageit-toolboxes\thumbs\ .\toolboxes\thumbs\
copy .\bioimageit-toolboxes\toolboxes.json .\toolboxes\toolboxes.json
copy .\bioimageit-toolboxes\tools.json .\toolboxes\tools.json
copy .\bioimageit-toolboxes\formats.json .\formats.json
REM rd /s /q .\bioimageit-toolboxes

REM create shortcuts
copy .\bioimageit-package\windows\BioImageIT.bat .\BioImageIT.bat
copy .\bioimageit-package\windows\BioImageIT-Browser.bat .\BioImageIT-Browser.bat
copy .\bioimageit-package\windows\BioImageIT-Toolboxes.bat .\BioImageIT-Toolboxes.bat
copy .\bioimageit-package\windows\BioImageIT-Runner.bat .\BioImageIT-Runner.bat
copy .\bioimageit-package\windows\BioImageIT-Viewer.bat .\BioImageIT-Viewer.bat
copy .\bioimageit-package\windows\jupyter.bat .\jupyter.bat
copy .\bioimageit-package\windows\workspace.bat .\workspace.bat


REM workspace
mkdir workspace

REM install and config packages
pip install .\bioimageit_formats
pip install .\bioimageit_core
pip install .\bioimageit_gui
pip install .\bioimageit_viewer
python bioimageit_core\config.py "%USERNAME%" %in_backend%
python bioimageit_gui\config.py 
