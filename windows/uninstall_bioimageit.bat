::[Bat To Exe Converter]
::
::fBE1pAF6MU+EWHreyHcjLQlHcCqtEiubIpg1xtTf4P2JrkIcUPEDbYHS1KeaIewf1Uftep8g131fkd9CDhpMHg==
::fBE1pAF6MU+EWHreyHcjLQlHcCqtEiubIpg1xtTf4P2JrkIcUPEDaorW1aKLH+Ia5UzpdJEo325lncUaQhlZanI=
::YAwzoRdxOk+EWAnk
::fBw5plQjdG8=
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
::YxY4rhs+aU+JeA==
::cxY6rQJ7JhzQF1fEqQJQ
::ZQ05rAF9IBncCkqN+0xwdVs0
::ZQ05rAF9IAHYFVzEqQJQ
::eg0/rx1wNQPfEVWB+kM9LVsJDGQ=
::fBEirQZwNQPfEVWB+kM9LVsJDGQ=
::cRolqwZ3JBvQF1fEqQJQ
::dhA7uBVwLU+EWDk=
::YQ03rBFzNR3SWATElA==
::dhAmsQZ3MwfNWATElA==
::ZQ0/vhVqMQ3MEVWAtB9wSA==
::Zg8zqx1/OA3MEVWAtB9wSA==
::dhA7pRFwIByZRRnk
::Zh4grVQjdCyDJGyX8VAjFDV7YkSjGEaTKIk45+vu4u+Jtl4hQew2dpzP27iCH+Ia5UzpdJEo324UndMJbA==
::YB416Ek+Zm8=
::
::
::978f952a14a936cc963da21a135fa983
rem ARE YOU SURE YOU WANT TO UNINSTALL BIOIMAGEIT ? If YES, press ENTER

pause

rmdir /s /q "C:\Users\%USERNAME%\AppData\Roaming\Microsoft\Windows\Start Menu\Programs\BioimageIT"

del "C:\Users\%USERNAME%\Desktop\BioimageIT_management.lnk"
del "C:\Users\%USERNAME%\Desktop\BioimageIT_processing.lnk"


rem DONE !

call "C:\Users\%USERNAME%\BioimageIT_installation_files\bioimageit-install\remove_bioimageit_env.bat"

rem UNINSTALL CONDA ? If YES, press ENTER. If NO, just  close the window

pause

start /D "C:\Users\%USERNAME%\BioimageIT_installation_files\Miniconda3" Uninstall-Miniconda3.exe

rmdir /s /q "C:\Users\%USERNAME%\BioimageIT_installation_files"

pause