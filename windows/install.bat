set miniconda_path=C:\Users\"%USERNAME%"\BioImageIT\Miniconda3
set conda_path="C:\Users\%USERNAME%\BioImageIT\Miniconda3\condabin\conda.bat"
set python_path="C:\Users\%USERNAME%\BioImageIT\Miniconda3\envs\bioimageit\python.exe"

call %miniconda_path%\Scripts\activate.bat bioimageit

%conda_path% install -y git
%conda_path% install -c ome omero-py -y