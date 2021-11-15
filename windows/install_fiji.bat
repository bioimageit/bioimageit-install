rem INSTALLING FIJI/IMAGEJ

cd C:\Users\"%USERNAME%"\BioImageIT

curl https://downloads.imagej.net/fiji/latest/fiji-win64.zip > fiji.zip

powershell -command Expand-Archive -Force .\fiji.zip .\

del fiji.zip

cd Fiji.app
ImageJ-win64.exe --update all
cd C:\Users\"%USERNAME%"\BioImageIT
