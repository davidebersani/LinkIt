#!/bin/sh

# This script allows you to create a launcher for the menu.
# The launcher will be added to your menu and also to your desktop, if you want to.
# For other information: https://github.com/bersani96/LinkIt

## Variables
conf="/etc/linkit/linkit.conf"
version="3.2"
icon=0
# If $icon is set to 0, must use default icon. If $icon is set to 1, must use a custom icon set by the user.
desktop=0
# d indicate if the suer want add the launcher to his desktop

## Script

while getopts "n:i:c:e:t:dgvh" opt; do
    case  $opt in
    	g)
    		echo "Starting linkit with GUI..."
    		./linkit-gui.sh
    		exit 0
    		;;
    	v)
    		echo LinkIt - version $version
    		exit 0
    		;;
    	h)
    		echo "Usage: linkit.sh OPTION [ARGUMENTS]..."
    		echo "Options:"
    		echo -e "\t-h\tShow this help"
    		echo -e "\t-n NAME\tSet the name of the launcher"
    		echo -e "\t-i ICON\tSet the icon"
    		echo -e "\t-t TYPE\TSet type (a -> addres, c-> command). Insert ALWAYS -t before -e!!!"
    		echo -e "\t-e COMMAND\tSet the command to execute (command or URL)"
    		echo -e "\t-c CATEGORY;CATEGORY;....\tSet the categories separeted by ;"
    		echo -e "\t-d\tAdd the launcher to your Desktop "
    		echo -e "\t-g\tStart LinkIt with GUI"
    		echo -e "\t-v\tShow version"
    		exit 0
    		;;
    	n)
    		# Create the file
			touch "$OPTARG".desktop
			name=$OPTARG
			echo "[Desktop Entry]"  >> "$name".desktop
    		echo "Encoding=UTF-8"   	>> "$name".desktop
			echo "Type=Application" 	>> "$name".desktop
			echo "Version=1.0"      	>> "$name".desktop
			echo "Name=$OPTARG"       	>> "$name".desktop
			;;
		i)
			# Set the Icon
			echo "Icon=$OPTARG" >> "$name".desktop
			icon=1
			;;
		c)
			# Set categories
			echo "Categories=$OPTARG" >> "$name".desktop
			;;
		t)
			# Set type: addres or command
			if [ "$OPTARG" = "a" ]
			then
				# Read the browser to use
				read t < $conf
			else
				t="command"
			fi
			;;
		e)
			# Set command 
			if [ "$t" = "command" ]
			then
				echo "Exec=$OPTARG" >> "$name".desktop
			else
				echo "Exec=$t $OPTARG" >> "$name".desktop
			fi
			;;
		d)
			desktop=1
			;;
		\?)
      		echo "Invalid option: -$OPTARG" >&2
      		;;
	esac
done
# Control the icon
if [ $icon -eq 0 ]
then
	# Use default icon
	echo "Icon=application-default-icon" >> "$name".desktop
fi
chmod +x "$name".desktop
if [ $desktop -eq 1 ]
then
	test -f ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs && source ${XDG_CONFIG_HOME:-~/.config}/user-dirs.dirs
	desktop=${XDG_DESKTOP_DIR:-$HOME/Desktop}
	if [ -e "$desktop" ]
	then
  	  cp "$name".desktop "$desktop"
	fi
fi
mkdir -p "~/.local/share/applications/"
mv "$name".desktop ~/.local/share/applications/
if [ $? -eq 0 ]
then
	echo "Launcher successfully created"
else
    echo "The launcher cannot be created"
fi
