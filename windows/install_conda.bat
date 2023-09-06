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


rem installation Miniconda
if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" curl https://repo.anaconda.com/miniconda/Miniconda3-py39_23.5.2-0-Windows-x86_64.exe --output miniconda_installer.exe
if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" start /wait "" miniconda_installer.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%bioimageit_dir%\Miniconda3
if exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" echo Miniconda already installed
	
if exist miniconda_installer.exe del miniconda_installer.exe	


set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"

call %miniconda_path%\Scripts\activate.bat base

call %conda_path% update conda -y
call %conda_path% install openssl -y
rem pip install pyOpenSSL

rem call %conda_path% upgrade conda -y
call %conda_path% config --add channels conda-forge
call %conda_path% config --add channels bioimageit
call %conda_path% create -y --name bioimageit python=3.9

rem call install.bat
set miniconda_path=%bioimageit_dir%\Miniconda3
set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"
set python_path="%bioimageit_dir%\Miniconda3\envs\bioimageit\python.exe"

call %conda_path% update conda -y

call %miniconda_path%\Scripts\activate.bat bioimageit

call %conda_path% install openssl -y
rem pip install pyOpenSSL

call %conda_path% install -y git 
call %conda_path% install -y -c ome omero-py
call %conda_path% install -y -c conda-forge gitpython
call %conda_path% install -y -c ome bioformats2raw
call %conda_path% install -y imageio-ffmpeg


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
git clone https://github.com/bioimageit/bioimageit_framework.git --branch v0.1.3
git clone https://github.com/bioimageit/bioimageit_core.git --branch v0.1.3
git clone https://github.com/bioimageit/bioimageit_gui.git --branch v0.1.3
git clone https://github.com/bioimageit/bioimageit_formats.git --branch v0.1.3
git clone https://github.com/bioimageit/bioimageit_viewer.git --branch v0.1.3
git clone https://github.com/bioimageit/bioimageit-toolboxes.git
git clone https://github.com/bioimageit/bioimageit-package.git
git clone https://github.com/bioimageit/bioimageit-install.git
git clone https://github.com/bioimageit/bioimageit-notebooks.git

rem plugins
git clone https://github.com/bioimageit/bioimageit-omero.git --branch v0.1.3
