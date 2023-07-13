rem ARE YOU SURE YOU WANT TO UNINSTALL BIOIMAGEIT ? If YES, press ENTER

pause

rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"

del "C:\Users\%USERNAME%\Desktop\BioimageIT.lnk"


rem Shortcuts removed


rem UNINSTALL CONDA ? If YES, press ENTER. If NO, just  close the window

pause

start /D "C:\Users\%USERNAME%\BioImageIT\Miniconda3" Uninstall-Miniconda3.exe

rem Miniconda uninstalled

rem pause

if not exist ".\Miniconda3\Uninstall-Miniconda3.exe" rmdir /s /q "C:\Users\%USERNAME%\BioImageIT"

rem rmdir /s /q "C:\Users\%USERNAME%\BioImageIT"

rem BioImageIT removed

rem UNINSTALLATION FINISHED, do not hesitate do install it again ;)

pause
