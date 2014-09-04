#!/usr/bin/env bash

# This script uninstall LinkIt automatically
# It must be executed as root

if [ $UID -ne 0 ]; then
    echo "This script must be executed as root." >&2
    exit 1
fi

sudo rm /usr/bin/linkit.sh
sudo rm -rf /etc/linkit
sudo rm /usr/share/applications/linkit.desktop
sudo rm /usr/share/icons/hicolor/48x48/linkit.png

echo "LinkIt removed"
