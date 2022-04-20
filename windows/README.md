# PS1 to exe conversion instructions
You need to install the PS2EXE Powershell extension with the command (Powershell terminal) :
```bash
Install-Module ps2exe
```

Then, type the following command in the Powershell Terminhal :
```bash
ps2exe PATH_TO/install_BioImageIT.ps1 PATH_TO/YOUR_NEW_EXE.exe
```

# Change the exe icon :
```bash
PATH_TO/rcedit-x64.exe PATH_TO/BioImageIT_install.exe --set-icon PATH_TO/YOUR_NEW_ICON.exe
```
