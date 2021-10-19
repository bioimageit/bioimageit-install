set miniconda_path=C:\Users\"%USERNAME%"\BioimageIT_installation_files\Miniconda3
set conda_path="C:\Users\%USERNAME%\BioimageIT_installation_files\Miniconda3\condabin\conda.bat"
set python_path="C:\Users\%USERNAME%\BioimageIT_installation_files\Miniconda3\envs\bioimageit\python.exe"

call %miniconda_path%\Scripts\activate.bat bioimageit

%conda_path% install -y git