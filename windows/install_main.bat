::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcDSXPmezBYk45+vu4u+Jtl4hVuswcYLa3bGHNK0a5FbwdJohm3dbkcUwBRVLahOnYkE2qHoi
::fBE1pAF6MU+EWHreyHcjLQlHcDSXPmezBYk45+vu4u+Jtl4hVuswcYLa3bGHNK0a5FbwdJohm3dbkcUwBRVLahOnYjA1r3pHpGOMI4meshuB
::fBE1pAF6MU+EWHreyHcjLQlHcDSXPmezBYk45+vu4u+Jtl4hVuswcYLa3bGHNK0a5FbwdJohm3dbkcUwBRVLahOnYjA3pmBGt1uBOMSXth2vSEmdhg==
::fBE1pAF6MU+EWHreyHcjLQlHcDSXPmezBYk45+vu4u+Jtl4hVuswcYLa3bGHNK0a5FbwdJohm3dbkcUwBRVLahOnYjA5qGdM+GaEI6c=
::YAwzoRdxOk+EWAjk
::fBw5plQjdCyDJGyX8VAjFCtBTgiLP1eeCbYJ5e31+/m7oEQSXe8+f4rSzvmHLvMH60noOJss33RmtOQrIyR+XDvlZww7yQ==
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
::Zh4grVQjdCyDJGyX8VAjFDV7YkSjGEaTKIk45//14+WGpl4hduswcYLa3bGnFN8a5FbwdJoh02gUndMJbA==
::YB416Ek+Zm8=
::
::
::978f952a14a936cc963da21a135fa983
rem Is Winget already installed ?
start ms-appinstaller:?source=https://aka.ms/getwinget

pause

set installer_dir=%CD%

cd "C:\Users\%USERNAME%"
mkdir BioimageIT_installation_files
cd BioimageIT_installation_files

copy "%installer_dir%\install.bat" .\install.bat
copy "%installer_dir%\install_main.bat" .\install_main.bat
copy "%installer_dir%\install_aftergit.bat" .\install_aftergit.bat
copy "%installer_dir%\install_conda_docker.bat" .\install_conda_docker.bat

call install_conda_docker.bat

call install.bat

call install_aftergit.bat




rem make shortcuts on desktop
@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\BioimageIT_processing.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioimageIT_installation_files\data_processing.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%
 

@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "%USERPROFILE%\Desktop\BioimageIT_management.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioimageIT_installation_files\data_management.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%



rem makes shortcuts in start menu
mkdir "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"

@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\data_processing.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioimageIT_installation_files\data_processing.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%




@echo off
set SCRIPT="%TEMP%\%RANDOM%-%RANDOM%-%RANDOM%-%RANDOM%.vbs"
echo Set oWS = WScript.CreateObject("WScript.Shell") >> %SCRIPT%
echo sLinkFile = "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT\data_management.lnk" >> %SCRIPT%
echo Set oLink = oWS.CreateShortcut(sLinkFile) >> %SCRIPT%
echo oLink.TargetPath = "C:\Users\%USERNAME%\BioimageIT_installation_files\data_management.bat" >> %SCRIPT%
echo oLink.Save >> %SCRIPT%
cscript /nologo %SCRIPT%
del %SCRIPT%


pause