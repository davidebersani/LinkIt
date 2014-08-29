#!/bin/sh
#This scirpt allow to create a launcher for the menù. This launcher will added to your menù and also to your desktop, if you want.
#For other information: https://github.com/bersani96/LinkIt
########################## Variables ##############################
prog="Link It"
conf="/etc/linkit/linkit.conf"
############################ Functions #############################

set_borwser(){
	read b < $conf
}

#Create .desktop file (starter for the menù)
file_desktop(){
        echo "[Desktop Entry]" >>$nome.desktop
        echo "Encoding=UTF-8" >>$nome.desktop
        echo "Type=Application" >>$nome.desktop
        echo "Version=1.0" >>$nome.desktop
        echo "Name=$nome" >>$nome.desktop
        #Check if the user want to use a custom icon
        zenity --question --title="$prog" --text="Do you want to use a custom icon?\nIf no, a default icon will be used."
        if [ $? -eq 0 ]
        then
                #Choose the icon
                icon=`zenity --file-selection --title="Choose the icon"`
                echo "Icon=$icon" >>$nome.desktop
        else
                #Else, i use a random icon
                echo "Icon=application-default-icon" >>$nome.desktop
        fi
        choose=`zenity --list --title="$prog" \
	  --text="What does the launcher should open?" \
	  --column="Options :" \
			"Comand" \
			"URL address"`
		
		case $choose in
		"Comand")
			dato=`zenity --entry --title="$prog" --text="Insert the command"`
        	echo "Exec=$dato" >>$nome.desktop
        ;;
        "URL address")
        	set_borwser
        	dato=`zenity --entry --title="$prog" --text="Insert the address"`
        	echo "Exec=$b $dato" >>$nome.desktop
        ;;
        esac
        zenity --question --title="$prog" --text="Does the launcher start in a terminal?"
        if [ $? -eq 0 ]
        then
                echo "Terminal=true" >>$nome.desktop
        else
                echo "Terminal=false" >>$nome.desktop
        fi
        c=`zenity --list --title="$prog" --text="Choose the category" --column="Options: " "AudioVideo" "Audio" "Video" "Development" "Education"\
        "Game" "Graphics" "Network" "Office" "Settings" "System"`
        echo "Categories=$c" >>$nome.desktop
}

##################################### Scritpt #####################################
#Read the name of the launcher
nome=`zenity --entry --title="$prog" --text="Insert the name of your launcher"`
if [ "$nome" = '' ]
then
	echo "Impossible to create launcher"
	zenity --error --title="$prog" --text="Impossible to create the launcher without the name"
	exit 1
fi
#Create the file
touch $nome.desktop
file_desktop
chmod +x $nome.desktop
zenity --question --title="$prog" --text="Do you want to add this launcher to your desktop?"
if [ $? -eq 0 ]
then
	if [ -e ~/Desktop ]
	then
		cp $nome.desktop ~/Desktop/
	else
		cp $nome.desktop ~/Scrivania/
	fi
fi
mv $nome.desktop ~/.local/share/applications/
if [ $? -eq 0 ]
then
	zenity --info --title="$prog" --text="Launcher successfully created"
else
	zenity --error --title="$prog" --text="The launcher cannot be created"
fi
