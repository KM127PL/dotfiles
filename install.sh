#!/bin/bash

if [[ "$(uname)" -ne "Linux" ]]; then
	echo "[!] Not running Linux, exiting without further changes..."
else
	echo "[!] Running $(uname)";
fi

read -p "[?] Are you sure to procceed with the installation? [Y\\n] " choice
if [ $choice == "n" ]; then
	exit
fi

echo "[!] Installing packages from ./data/packages.x86_64"
read -p "[?] Are you sure you want to install these packages? [Y\\n] " pkgChoice
if [ $pkgChoice == "y" ]; then
	pacman -S --needed - < ./data/packages.x86_64;
else
	echo "[!] Skipping package installation.";
fi

echo "[!] Asking for additional tools"
read -p "[?] Do you wish to install a screenshotting tool? [Y\\n] " ssChoice

if [ $ssChoice == "y" ]; then
	git clone https://github.com/denisoster/awesomewm-screenshot.git $XDG_CONFIG_HOME/awesome/.
	mkdir $HOME/Pictures/
fi

echo "[!] Copying config files for user $USER"
cp ./data/config /home/$USER/.config -r

echo "[!] Copying xinit config files"
cp ./data/xinitrc /home/$USER/.xinitrc

echo "[!] Copying kmsystems theme over"
cp ./data/themes/* /usr/share/awesome/themes/. -r

echo "[!] Successfully installed!"
