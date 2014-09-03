#!/bin/sh

# This script installs LinkIt automatically
# It must be executed as root

cp linkit.sh /usr/bin/
cp -R etc/linkit/ /etc/
cp applications/linkit.desktop /usr/share/applications
cp applications/linkit.png /usr/share/icons/hicolor/48x48/

echo "Installation successful."
echo "Launch LinkIt from terminal with linkit.sh or find it in your menu."
