
set conda_url=https://repo.anaconda.com/miniconda/Miniconda3-py39_23.5.2-0-Windows-x86_64.exe

set miniconda_path=%bioimageit_dir%\Miniconda3
set conda_path="%bioimageit_dir%\Miniconda3\condabin\conda.bat"
set python_path="%bioimageit_dir%\Miniconda3\envs\bioimageit\python.exe"
set conda_activate="%miniconda_path%\Scripts\activate.bat"

set in_destination_dir="."
set in_backend="CONDA"

set LOGFILE=%1installation.log

set biit_framework_tag=v0.1.3
set biit_core_tag=v0.1.3
set biit_gui_tag=v0.1.3
set biit_formats_tag=v0.1.3
set biit_viewer_tag=v0.1.3
set biit_toolboxes_tag=
set biit_package_tag=
set biit_install_tag=v0.1.3
set biit_notebooks_tag=
set biit_omero_tag=v0.1.3

set framework_repo=https://github.com/bioimageit/bioimageit_framework.git
echo %framework_repo%
if not [%biit_framework_tag%]==[] set framework_repo=%framework_repo% --branch %biit_framework_tag%
echo %framework_repo%

set core_repo=https://github.com/bioimageit/bioimageit_core.git
if not [%biit_core_tag%]==[] set core_repo=%core_repo% --branch %biit_core_tag%

set gui_repo=https://github.com/bioimageit/bioimageit_gui.git
if not [%biit_gui_tag%]==[] set gui_repo=%gui_repo% --branch %biit_gui_tag%

set formats_repo=https://github.com/bioimageit/bioimageit_formats.git
if not [%biit_formats_tag%]==[] set formats_repo=%formats_repo% --branch %biit_formats_tag%

set viewer_repo=https://github.com/bioimageit/bioimageit_viewer.git
if not [%biit_viewer_tag%]==[] set viewer_repo=%viewer_repo% --branch %biit_viewer_tag%

set toolboxes_repo=https://github.com/bioimageit/bioimageit-toolboxes.git
if not [%$biit_toolboxes_tag%]==[] set toolboxes_repo=%toolboxes_repo% --branch %biit_toolboxes_tag%

set install_repo=https://github.com/bioimageit/bioimageit-install.git
if not [%biit_install_tag%]==[] set install_repo=%install_repo% --branch %biit_install_tag%

set package_repo=https://github.com/bioimageit/bioimageit-package.git
if not [%biit_package_tag%]==[] set package_repo=%package_repo% --branch %biit_package_tag%

set notebooks_repo=https://github.com/bioimageit/bioimageit-notebooks.git
if not [%biit_notebooks_tag%]==[] set notebooks_repo=%notebooks_repo% --branch %biit_notebooks_tag%

set omero_repo=https://github.com/bioimageit/bioimageit-omero.git
if not [%biit_omero_tag%]==[] set omero_repo=%omero_repo% --branch %biit_omero_tag%

set fiji_version=https://downloads.imagej.net/fiji/latest/fiji-win64.zip