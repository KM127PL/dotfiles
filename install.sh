#!/bin/bash

if [ "$(id -u)" -eq 0 ]; then
	echo '[!] This script must not be run by root/sudo!' >&2
	exit 1
fi

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
	sudo pacman -Sy --needed - < ./data/packages.x86_64;
else
	echo "[!] Skipping package installation.";
fi

echo "[!] Asking for additional tools"
read -p "[?] Do you wish to install a screenshotting tool? [Y\\n] " ssChoice

if [ $ssChoice == "y" ]; then
	git clone https://github.com/denisoster/awesomewm-screenshot.git $HOME/.config/awesome/.
	mkdir $HOME/Pictures/
fi

echo "[!] Copying config files for user $USER"
cp ./data/config/* $HOME/.config/. -r

echo "[!] Copying xinit config files"
cp ./data/xinitrc $HOME/.xinitrc

echo "[!] Copying kmsystems theme over"
sudo cp ./data/themes/* /usr/share/awesome/themes/. -r

echo "[!] Copying ps1 over"
sudo mkdir /etc/profile.d
sudo cp ./data/ps1.sh /etc/profile.d/ps1.sh


echo "[!] Copying bashrc config over"
sudo cp ./data/bash.bashrc /etc/bash.bashrc

echo "[!] Copying profile config over"
sudo cp ./data/profile /etc/profile

echo "[!] Copying lightdm config over"
sudo cp ./data/lightdm.conf /etc/lightdm/lightdm.conf

echo "[!] Copying bashrc over"
cp ./data/bashrc $HOME/.bashrc

echo "[!] Updating bashrc"
source $HOME/.bashrc

echo "[!] Successfully installed!"
