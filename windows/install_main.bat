rem Is Winget already installed ?
rem start ms-appinstaller:?source=https://aka.ms/getwinget

rem pause

set installer_dir=%CD%

cd "C:\Users\%USERNAME%"
mkdir BioImageIT
cd BioImageIT


rem call install_conda_docker.bat
rem mkdir "C:\Users\%USERNAME%\Programes_bioimageIT"

rem installation Miniconda
if not exist "C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat" curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Windows-x86_64.exe --output miniconda_installer.exe
if not exist "C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat" start /wait "" miniconda_installer.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%UserProfile%\BioImageIT\Miniconda3
if exist "C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat" echo Miniconda already installed
	
if exist miniconda_installer.exe del miniconda_installer.exe	


rem installation Docker Desktop
rem if not exist C:\"Program Files"\Docker\Docker\"Docker Desktop.exe" (winget install -e --id Docker.DockerDesktop)
rem if exist C:\"Program Files"\Docker (echo Docker Desktop already installed)



rem set BASEDIR=%CD%
rem cd %BASEDIR%



set conda_path="C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat"

call %conda_path% upgrade conda -y
call %conda_path% config --add channels conda-forge
call %conda_path% config --add channels bioimageit
call %conda_path% create -y --name bioimageit python=3.9


rem call install.bat
set miniconda_path=C:\Users\"%USERNAME%"\BioImageIT\Miniconda3
set conda_path="C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat"
set python_path="C:\Users\%USERNAME%\BioImageIT\Miniconda3\envs\bioimageit\python.exe"

call %miniconda_path%\Scripts\activate.bat bioimageit

call %conda_path% install -y git 
call %conda_path% install -y -c ome omero-py


rem call install_aftergit.bat
set in_destination_dir="."
set in_backend="CONDA"

REM check inputs
echo "destination dir:" %in_destination_dir%
echo "backend:" %in_backend%


cd %in_destination_dir%
rem %python_path% -m venv .bioimageit-env
rem call .bioimageit-env\Scripts\activate

git clone https://github.com/bioimageit/bioimageit_framework.git
git clone https://github.com/bioimageit/bioimageit_core.git
git clone https://github.com/bioimageit/bioimageit_gui.git
git clone https://github.com/bioimageit/bioimageit_formats.git
git clone https://github.com/bioimageit/bioimageit_viewer.git
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git
git clone https://github.com/bioimageit/bioimageit-install.git
git clone https://github.com/bioimageit/bioimageit-notebooks.git

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
pip install .\bioimageit_framework
pip install .\bioimageit_core
pip install .\bioimageit_gui
pip install .\bioimageit_viewer
pip install jupyter
python bioimageit_core\config.py "%USERNAME%" %in_backend%
python bioimageit_gui\config.py 



rem call install_fiji.bat
rem INSTALLING FIJI/IMAGEJ

cd C:\Users\"%USERNAME%"\BioImageIT

curl https://downloads.imagej.net/fiji/latest/fiji-win64.zip > fiji.zip

powershell -command Expand-Archive -Force .\fiji.zip .\

del fiji.zip

cd Fiji.app
ImageJ-win64.exe --update all
cd C:\Users\"%USERNAME%"\BioImageIT




rem make shortcuts on desktop
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\BioimageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\BioImageIT.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

rem makes shortcuts in start menu
mkdir "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"

@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\BioImageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\BioImageIT.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Workspace.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\workspace.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Imagej.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\Fiji.app\ImageJ-win64.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Jupyter.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\jupyter.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


rem start menu shortcut for uninstallaton
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\uninstall_BioimageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\bioimageit-install\windows\uninstall_bioimageit.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


rem Remove useless files & folders
cd "C:\Users\%USERNAME%\BioImageIT"
rmdir /s /q bioimageit-package
rmdir /s /q bioimageit-toolboxes


xcopy "C:\Users\%USERNAME%\BioImageIT\toolboxes\tools\fiji_utils" "C:\Users\%USERNAME%\BioImageIT\Fiji.app\macros" 


pause