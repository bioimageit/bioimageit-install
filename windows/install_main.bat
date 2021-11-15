::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWH3eyHYiKQ1VRQi+HmK1D7gd7+3S29WOrF4JVe4zeZvS1bqxJukf71bYd58i33dbn84FGFZRcAG/bwM4lXlLuGCKINSgugHyXkmF6gUyGnEU
::fBE1pAF6MU+EWH3eyHYiKQ1VRQi+HmK1D7gd7+3S29WOrF4JVe4zeZvS1bqxJukf71bYd58i33dbn84FGFZRcAG/bwM4lXlLuGCKINSgugHyXkmF6nQxHXFxlWTZmGU5YccI
::fBE1pAF6MU+EWH3eyHYiKQ1VRQi+HmK1D7gd7+3S29WOrF4JVe4zeZvS1bqxJukf71bYd58i33dbn84FGFZRcAG/bwM4lXlLuGCKINSgugHyXkmF6nQzFGtwhlzUgygwZcEmmMIXsw==
::fBE1pAF6MU+EWH3eyHYiKQ1VRQi+HmK1D7gd7+3S29WOrF4JVe4zeZvS1bqxJukf71bYd58i33dbn84FGFZRcAG/bwM4lXlLuGCKINSgugHyXkmF6nQ2Em99yWHRmEs=
::fBE1pAF6MU+EWH3eyHYiKQ1VRQi+HmK1D7gd7+3S29WOrF4JVe4zeZvS1bqxJukf71bYd58i33dbn84FGFZRcAG/bwM4lXlLuGCKINSgugHyXkmF6nQ9Gmx6yWHRmEs=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCuDJG2W9VQxIRdobg2NNWa7AbA13Nfy4fmTo0ERVfY2d4Hk3L2CJfMv6EzrfJss0X9TjIYFAghMfx6nUhg9p2pNoXe5PsSTvUHoSUfp
::YAwzuBVtJxjWCl3EqQJgSA==
::ZR4luwNxJguZRRnk
::Yhs/ulQjdF+5
::cxAkpRVqdFKZSDk=
::cBs/ulQjdF+5
::ZR41oxFsdFKZSDk=
::eBoioBt6dFKZSDk=
::cRo6pxp7LAbNWATEpSI=
::egkzugNsPRvcWATEpCI=
::dAsiuh18IRvcCxnZtBJQ
::cRYluBh/LU+EWAnk
::YxY4rhs+aU+IeA==
::cxY6rQJ7JhzQF1fEqQJgZko0
::ZQ05rAF9IBncCkqN+0xwdVsEAlXi
::ZQ05rAF9IAHYFVzEqQISIRRdQQWFOUKORrwS+/z64+aCsC0=
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQIZJghATQiOLyuYD7oV5en86sOz4gBdZ8cNSKb49dQ=
::dhA7uBVwLU+EWGqhxnIZCzQ0
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCuDJG2W9VQxIRdobg2NNWa7AbA13Nfy4fmTo0ERVfY2d4Hk3L2CJfMv6EzrfJss0X9TjIYFAghMfx6nUhg9p2pNoXe5Fc6TugLgTU2g0nQ5FXZghm/ciTl1Zctt+g==
::YB416Ek+Zm8=
::
::
::978f952a14a936cc963da21a135fa983
rem Is Winget already installed ?
rem start ms-appinstaller:?source=https://aka.ms/getwinget

rem pause

set installer_dir=%CD%

cd "C:\Users\%USERNAME%"
mkdir BioImageIT
cd BioImageIT

copy "%installer_dir%\install.bat" .\install.bat
copy "%installer_dir%\install_main.bat" .\install_main.bat
copy "%installer_dir%\install_aftergit.bat" .\install_aftergit.bat
copy "%installer_dir%\install_conda_docker.bat" .\install_conda_docker.bat
copy "%installer_dir%\install_fiji.bat" .\install_fiji.bat

call install_conda_docker.bat

call install.bat

call install_aftergit.bat

call install_fiji.bat


rem make shortcuts on desktop
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\BioimageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\BioImageIT.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%

rem makes shortcuts in start menu
mkdir "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"

@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\BioImageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\BioImageIT.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Workspace.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\workspace.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\Imagej.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\Fiji.app\ImageJ-win64.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%



rem start menu shortcut for uninstallaton
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\uninstall_BioimageIT.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioImageIT\bioimageit-install\windows\uninstall_bioimageit.exe" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


cd "C:\Users\%USERNAME%\BioImageIT"
del "C:\Users\%USERNAME%\BioImageIT\install_main.bat"
del "C:\Users\%USERNAME%\BioImageIT\install.bat"
del "C:\Users\%USERNAME%\BioImageIT\install_conda_docker.bat"
del "C:\Users\%USERNAME%\BioImageIT\install_aftergit.bat"


pause