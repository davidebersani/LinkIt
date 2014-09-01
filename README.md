#Link It
This is a script for bash that allow you to simplify and accelerate the creation of launchers for menù (.dekstop file). 
Launchers that are created with this script will automatically added to your menù and, if you want, you can add it also in your dekstop. These launchers work on every dekstop enviroment: KDE, Gnome, LXDE, XFCE, MATE and other! 

#New version 2.2!
##Changelog
-Version 2.2: 
	*Introduced a configuration file! It is /etc/linkit.conf.
	*Introduced a setup file.
-Version 2.1: Added the possibility to add your launchers in your desktop.

#Installation
Requirements:
- zenity

For install this script:
```sh
wget https://github.com/bersani96/LinkIt/archive/master.zip
unzip master.zip
```
With these istructions you download and extract the script and other files. Now install it.
```sh
cd LinkIt-master
./setup.sh
```
Now you can launch the script with a simple comand.
```sh
linkit.sh
```

#Usage
For launch the script you can use the command:
```sh
linkit.sh
```
or you can use the launcher in your menù. After you have launched the script, follow the execution and your custom launchers will be created.
The script have a GUI.
