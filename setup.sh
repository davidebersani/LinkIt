#!/bin/sh
#This is a script that install LinkIt automatically
#This script must be executed as root
cp linkit.sh /usr/bin/
cp -R etc/linkit/ /etc/
cp applications/linkit.desktop /usr/share/applications
cp applications/linkit.png /usr/share/icons/hicolor/48x48/
#Configuration finished
echo "Configuration succesflully finished"
echo "Lunch linkit from terminal with linkit.sh or find it in your menù"
