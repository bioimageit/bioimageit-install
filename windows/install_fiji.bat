
cd %1
set bioimageit_dir=%1
echo %bioimageit_dir%

call :LOG >> %LOGFILE% 2>&1
exit /B

:LOG



rem call install_fiji.bat
rem INSTALLING FIJI/IMAGEJ

cd %bioimageit_dir%

curl %fiji_version > fiji.zip

powershell -command Expand-Archive -Force .\fiji.zip .\

del fiji.zip

cd Fiji.app
ImageJ-win64.exe --update all

cd %bioimageit_dir%

xcopy "%bioimageit_dir%\toolboxes\tools\fiji_utils" "%bioimageit_dir%\Fiji.app\macros" 
xcopy "%bioimageit_dir%\toolboxes\tools\fiji_plugins" "%bioimageit_dir%\Fiji.app\plugins"


rem SHORTCUTS
mkdir icons
copy .\bioimageit-install\windows\icon.ico .\icons\icon.ico
copy .\bioimageit-install\windows\uninstall.ico .\icons\uninstall.ico
copy .\bioimageit-install\linux\Workspace.ico .\icons\Workspace.ico
copy .\bioimageit-install\linux\jupyter.ico .\icons\jupyter.ico

cd %bioimageit_dir%\bioimageit-install\windows

rem make shortcuts on desktop
nircmd.exe shortcut "%bioimageit_dir%\BioImageIT.bat" "C:\Users\%USERNAME%\Desktop" "BioImageIT" "" "%bioimageit_dir%\icons\icon.ico"

rem makes shortcuts in start menu
set shortcut_folder="C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"
mkdir %shortcut_folder%
nircmd.exe shortcut "%bioimageit_dir%\BioImageIT.bat" %shortcut_folder% "BioImageIT" "" "%bioimageit_dir%\icons\icon.ico"
nircmd.exe shortcut "%bioimageit_dir%\workspace.bat" %shortcut_folder% "Workspace" "" "%bioimageit_dir%\icons\Workspace.ico"
nircmd.exe shortcut "%bioimageit_dir%\jupyter.bat" %shortcut_folder% "Jupyter" "" "%bioimageit_dir%\icons\jupyter.ico"
nircmd.exe shortcut "%bioimageit_dir%\uninstall_bioimageit.bat" %shortcut_folder% "uninstall_bioimageit" "" "%bioimageit_dir%\icons\uninstall.ico"

@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%shortcut_folder%\Imagej.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "%bioimageit_dir%\Fiji.app\ImageJ-win64.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%




rem Remove useless files & folders
cd %bioimageit_dir%
rmdir /s /q bioimageit-package
rmdir /s /q toolboxes\tools\fiji_utils
rmdir /s /q toolboxes\tools\fiji_plugins
rmdir /s /q bioimageit-install

