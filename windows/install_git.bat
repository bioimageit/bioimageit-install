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


rem rem installation Miniconda
rem if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Windows-x86_64.exe --output miniconda_installer.exe
rem if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" start /wait "" miniconda_installer.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%bioimageit_dir%\Miniconda3
rem if exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" echo Miniconda already installed
	
rem if exist miniconda_installer.exe del miniconda_installer.exe	


rem set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"

rem call %conda_path% upgrade conda -y
rem call %conda_path% config --add channels conda-forge
rem call %conda_path% config --add channels bioimageit
rem call %conda_path% create -y --name bioimageit python=3.9


rem rem call install.bat
rem set miniconda_path=%bioimageit_dir%\Miniconda3
rem set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"
rem set python_path="%bioimageit_dir%\Miniconda3\envs\bioimageit\python.exe"

rem call %miniconda_path%\Scripts\activate.bat bioimageit

rem call %conda_path% install -y git 
rem call %conda_path% install -y -c ome omero-py
rem call %conda_path% install -y -c conda-forge gitpython


rem call install_aftergit.bat
set in_destination_dir="."
set in_backend="CONDA"

REM check inputs
echo "destination dir:" %in_destination_dir%
echo "backend:" %in_backend%


cd %in_destination_dir%
cd %bioimageit_dir%
rem %python_path% -m venv .bioimageit-env
rem call .bioimageit-env\Scripts\activate

rem main app
git clone https://github.com/bioimageit/bioimageit_framework.git
git clone https://github.com/bioimageit/bioimageit_core.git
git clone https://github.com/bioimageit/bioimageit_gui.git
git clone https://github.com/bioimageit/bioimageit_formats.git
git clone https://github.com/bioimageit/bioimageit_viewer.git
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git
git clone https://github.com/bioimageit/bioimageit-install.git
git clone https://github.com/bioimageit/bioimageit-notebooks.git

rem plugins
git clone https://github.com/bioimageit/bioimageit-omero.git

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



rem rem call install_fiji.bat
rem rem INSTALLING FIJI/IMAGEJ

rem cd %bioimageit_dir%

rem curl https://downloads.imagej.net/fiji/latest/fiji-win64.zip > fiji.zip

rem powershell -command Expand-Archive -Force .\fiji.zip .\

rem del fiji.zip

rem cd Fiji.app
rem ImageJ-win64.exe --update all
rem cd %bioimageit_dir%

rem xcopy "%bioimageit_dir%\toolboxes\tools\fiji_utils" "%bioimageit_dir%\Fiji.app\macros" 
rem xcopy "%bioimageit_dir%\toolboxes\tools\fiji_plugins" "%bioimageit_dir%\Fiji.app\plugins"


rem rem SHORTCUTS
rem cd %bioimageit_dir%
rem mkdir icons
rem copy .\bioimageit-install\windows\icon.ico .\icons\icon.ico
rem copy .\bioimageit-install\windows\uninstall.ico .\icons\uninstall.ico
rem copy .\bioimageit-install\linux\Workspace.ico .\icons\Workspace.ico
rem copy .\bioimageit-install\linux\jupyter.ico .\icons\jupyter.ico

rem cd %bioimageit_dir%\bioimageit-install\windows
rem dir

rem rem make shortcuts on desktop
rem nircmd.exe shortcut "%bioimageit_dir%\BioImageIT.bat" "C:\Users\%USERNAME%\Desktop" "BioImageIT" "" "%bioimageit_dir%\icons\icon.ico"

rem rem makes shortcuts in start menu
rem mkdir "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"
rem nircmd.exe shortcut "%bioimageit_dir%\BioImageIT.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT" "BioImageIT" "" "%bioimageit_dir%\icons\icon.ico"
rem nircmd.exe shortcut "%bioimageit_dir%\workspace.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT" "Workspace" "" "%bioimageit_dir%\icons\Workspace.ico"
rem nircmd.exe shortcut "%bioimageit_dir%\jupyter.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT" "Jupyter" "" "%bioimageit_dir%\icons\jupyter.ico"
rem nircmd.exe shortcut "%bioimageit_dir%\uninstall_bioimageit.bat" "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT" "uninstall_bioimageit" "" "%bioimageit_dir%\icons\uninstall.ico"

rem @echo off
rem set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
rem echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
rem echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Imagej.lnk" >> %SCRIPT%
rem echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
rem echo oLink.TargetPath = "%bioimageit_dir%\Fiji.app\ImageJ-win64.exe" >> %SCRIPT%
rem echo oLink.Save >> %SCRIPT%
rem cscript /nologo %SCRIPT%
rem del %SCRIPT%




rem rem Remove useless files & folders
rem cd %bioimageit_dir%
rem rmdir /s /q bioimageit-package
rem rmdir /s /q toolboxes\tools\fiji_utils
rem rmdir /s /q toolboxes\tools\fiji_plugins
rem rmdir /s /q bioimageit-install

