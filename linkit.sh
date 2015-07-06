#!/bin/sh

# This script allows you to create a launcher for the menu.
# The launcher will be added to your menu and also to your desktop, if you want to.
# For other information: https://github.com/bersani96/LinkIt

## Variables
prog="LinkIt"
conf="/etc/linkit/linkit.conf"

## Functions
set_browser(){
    read b < $conf
}

# Create .desktop file (launcher for the menu)
file_desktop(){
    echo "[Desktop Entry]"  >> "$name".desktop
    echo "Encoding=UTF-8"   >> "$name".desktop
    echo "Type=Application" >> "$name".desktop
    echo "Version=1.0"      >> "$name".desktop
    echo "Name=$name"       >> "$name".desktop

    # Check if the user want to use a custom icon
    zenity --question --title="$prog" --text="Do you want to use a custom icon ?\nIf not, a default icon will be used."
    if [ $? -eq 0 ]
    then
        # Choose the icon
        icon=`zenity --file-selection --title="Choose the icon"`
        echo "Icon=$icon" >> "$name".desktop
    else
        # Else use a default icon
        echo "Icon=application-default-icon" >> "$name".desktop
    fi
    choose=`zenity --list --title="$prog" \
        --text="What does the launcher should open ?" \
        --column="Options :" \
        "Command" \
        "URL address"`
	es=$?
	check_status
    case $choose in
        "Command")
            cmd=`zenity --entry --title="$prog" --text="Insert the command"`
            es=$?
			check_status
            echo "Exec=$cmd" >> "$name".desktop
            ;;
        "URL address")
            set_browser
            cmd=`zenity --entry --title="$prog" --text="Insert the address"`
            es=$?
			check_status
            echo "Exec=$b $cmd" >> "$name".desktop
            ;;
    esac
    zenity --question --title="$prog" --text="Does the launcher start in a terminal ?"
    if [ $? -eq 0 ]
    then
        echo "Terminal=true"  >> "$name".desktop
    else
        echo "Terminal=false" >> "$name".desktop
    fi
    zenity --list --checklist --column="" --column="Categories" false "AudioVideo" false "Audio" false "Video" false "Development" false "Education" false "Game" false "Graphics" false "Network" false "Office" false "Settings" false "System" > categories
    es=$?
	check_status
	c=`cut -d "|" -f 1- --output-delimiter ";" categories`
    echo "Categories=$c" >> "$name".desktop
    rm categories
}

#This 
check_status(){
	if [ $es -ne 0 ]
	then
		rm $name.desktop
		exit 1
	fi
}


## Script

# Read the name of the launcher
name=`zenity --entry --title="$prog" --text="Insert the name of your launcher"`
if [ "$name" = '' ]
then
    echo "Impossible to create a launcher without a name"
    zenity --error --title="$prog" --text="Impossible to create a launcher without a name"
    exit 1
fi

# Create the file
touch "$name".desktop
file_desktop
chmod +x "$name".desktop
test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
desktop=${XDG_DESKTOP_DIR:-$HOME/Desktop}
zenity --question --title="$prog" --text="Do you want to add this launcher to your desktop?"
if [ $? -eq 0 ] && [ -e "$desktop" ]
then
    cp "$name".desktop "$desktop"
fi
mkdir -p ~/.local/share/applications/
mv "$name".desktop ~/.local/share/applications/
if [ $? -eq 0 ]
then
    zenity --info --title="$prog" --text="Launcher successfully created"
else
    zenity --error --title="$prog" --text="The launcher cannot be created"
fi
