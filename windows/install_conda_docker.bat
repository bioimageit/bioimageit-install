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