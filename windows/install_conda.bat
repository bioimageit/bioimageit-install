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
if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" curl https://repo.anaconda.com/miniconda/Miniconda3-py39_4.10.3-Windows-x86_64.exe --output miniconda_installer.exe
if not exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" start /wait "" miniconda_installer.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%bioimageit_dir%\Miniconda3
if exist "%bioimageit_dir%\Miniconda3\condabin\conda.bat" echo Miniconda already installed
	
if exist miniconda_installer.exe del miniconda_installer.exe	


set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"

call %conda_path% upgrade conda -y
call %conda_path% config --add channels conda-forge
call %conda_path% config --add channels bioimageit

call %miniconda_path%\Scripts\activate.bat base && call %conda_path% install -y -c conda-forge mamba && mamba create -n bioimageit python=3.9 -y


rem call install.bat
set miniconda_path=%bioimageit_dir%\Miniconda3
set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"
set python_path="%bioimageit_dir%\Miniconda3\envs\bioimageit\python.exe"

call %miniconda_path%\Scripts\activate.bat bioimageit && mamba install -y git && mamba install -y -c ome omero-py && mamba install -y -c conda-forge gitpython


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
