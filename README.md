# LinkIt
#Attention! This is a testing version! 

If you want a stable version go to "master" [https://github.com/bersani96/LinkIt](branch).
=====
LinkIt is a Bash script that allows you to simplify and accelerate the creation of launchers for menu (.dekstop file).  
Launchers that are created with this script will automatically be added to your menu and, if you want it, also on your desktop.  
These launchers work on every desktop environment that follows the [Freedesktop specs](http://standards.freedesktop.org/desktop-entry-spec/latest/index.html):
KDE, Gnome, LXDE, XFCE, MATE and others!

# New version 3.2 Testing!
## Changelog
- Version 3.2
	* Now you can use LinkIt also from Terminal!!!
	 After you have installed LinkIt ([https://github.com/bersani96/LinkIt/tree/testing#installation](look here for how to install)) type in the terminal 
	 ```
	 linkit.sh -h 
	 ```
	 for obtain an help with all aviable options.
	 The version with GUI is also aviable. For start LinkIt with GUI type "linkit.sh -g"
- Version 3.1
	* Now the button "Cancel" stop the programm and allow you to exit without saving
	* Select different categories
	* Changed icon
	* Added script to remove LiknIt
- Version 3.0
	* A lot of changes have benn introduced in this version! A big thanks to @MisterDA 
	* Correct many typos and grammar errors. Improve readability, fix indentation
	* Prevent potential bug if $name contains special characters
	* Stop if not run by root
- Version 2.2:
    * Introduced a configuration file! It is `/etc/linkit.conf`.
    * Introduced a setup file.
- Version 2.1: Added the possibility to add your launchers in your desktop.

# Installation
Requirements:
- [zenity](https://help.gnome.org/users/zenity/stable/)

With these instructions you can download and extract the script :
```sh
wget https://github.com/bersani96/LinkIt/archive/master.zip
unzip master.zip
cd LinkIt-master
```
Then launch as root :
```sh
./setup.sh
```

Now you can launch the script from terminal with a simple command:
```sh
linkit.sh
```
or you can use the version with GUI using the launcher in your menu.

![Image of menu with Link It](http://sonnino1aquile.altervista.org/file/linkit-menu.png)

# Usage

To use LinkIt from terminal type
```sh
linkit.sh OPTION [ARGUMENTS]...
```
The aviable options are:
- 	-h	Show this help
- 	-n NAME	Set the name of the launcher
- 	-i ICON	Set the icon
- 	-t TYPE\TSet type (a -> addres, c-> command). Insert ALWAYS -t before -e!!!
- 	-e COMMAND	Set the command to execute (command or URL)
- 	-c CATEGORY;CATEGORY;....	Set the categories separeted by ;
- 	-d	Add the launcher to your Desktop 
- 	-g	Start LinkIt with GUI
- 	-v	Show version

If you use the launcher in your menu the version with GUI will be started.
