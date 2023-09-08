


cd %1
set bioimageit_dir=%1
echo %bioimageit_dir%

call config.bat

call :LOG >> %LOGFILE% 2>&1
exit /B

:LOG


rem installation Miniconda
if not exist %conda_path% curl %conda_url% --output miniconda_installer.exe
if not exist %conda_path% start /wait "" miniconda_installer.exe /InstallationType=JustMe /RegisterPython=0 /S /D=%bioimageit_dir%\Miniconda3
if exist %conda_path% echo Miniconda already installed
	
if exist miniconda_installer.exe del miniconda_installer.exe	




call %conda_activate% base
call %conda_path% update conda -y

call %conda_path% install openssl -y
rem pip install pyOpenSSL

call %conda_path% config --add channels conda-forge
call %conda_path% config --add channels bioimageit

call %conda_path% create -y --name bioimageit python=3.9
call %conda_activate% bioimageit

call %conda_path% install openssl -y
rem pip install pyOpenSSL

call %conda_path% install -y git 
call %conda_path% install -y -c ome omero-py
call %conda_path% install -y -c conda-forge gitpython
call %conda_path% install -y -c ome bioformats2raw
call %conda_path% install -y imageio-ffmpeg


REM check inputs
echo "backend:" %in_backend%

cd %bioimageit_dir%

rem main app
git clone %framework_repo%
git clone %core_repo%
git clone %gui_repo%
git clone %formats_repo%
git clone %viewer_repo%
git clone %toolboxes_repo%
git clone %package_repo%
git clone %install_repo%
git clone %notebooks_repo%

rem plugins
git clone %omero_repo%
