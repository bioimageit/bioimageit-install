#!/bin/bash
. ./install.conf

###################### FIJI ###########################
# create log file
exec >$installdir/install.log 2>&1

cd $installdir

wget https://downloads.imagej.net/fiji/$fiji_version/fiji-linux64.zip
unzip -o fiji-linux64.zip
rm fiji-linux64.zip

cp -a ./toolboxes/tools/fiji_utils/. ./Fiji.app/macros
