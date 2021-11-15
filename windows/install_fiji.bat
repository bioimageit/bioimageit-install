rem INSTALLING FIJI/IMAGEJ

cd C:\Users\"%USERNAME%"\BioImageIT

curl https://downloads.imagej.net/fiji/latest/fiji-win64.zip > fiji.zip

powershell -command Expand-Archive -Force .\fiji.zip .\

del fiji.zip
