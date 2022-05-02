rem set installer_dir=%CD%


cd %1
echo %1
set bioimageit_dir=%1
echo %bioimageit_dir%

set miniconda_path=%bioimageit_dir%\Miniconda3
set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"
set python_path="%bioimageit_dir%\Miniconda3\envs\bioimageit\python.exe"

set in_destination_dir="."
set in_backend="CONDA"


set LOGFILE=%1installation.log
call :LOG >> %LOGFILE% 2>&1
exit /B

:LOG

call %miniconda_path%\Scripts\activate.bat bioimageit

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
copy .\bioimageit-package\windows\jupyter.bat .\jupyter.bat
copy .\bioimageit-package\windows\workspace.bat .\workspace.bat
copy .\bioimageit-install\windows\uninstall_bioimageit.bat .\uninstall_bioimageit.bat


REM workspace
mkdir workspace
mkdir workspace\logs

REM install and config packages
pip install .\bioimageit_formats
pip install .\bioimageit_framework
pip install .\bioimageit_core
pip install .\bioimageit_gui
pip install .\bioimageit_viewer
pip install .\bioimageit-omero
pip install jupyter
python bioimageit_core\config.py "%USERNAME%" %in_backend%
python bioimageit_gui\config.py 


