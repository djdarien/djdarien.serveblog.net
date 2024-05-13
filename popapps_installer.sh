#!/bin/bash

# Log file
LOG_FILE="install_results.log"
exec > >(tee -i $LOG_FILE)
exec 2>&1

echo "Starting installation process..."

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Discord
echo "Installing Discord..."
wget -O discord.deb "https://discordapp.com/api/download?platform=linux&format=deb"
sudo apt install -y ./discord.deb
rm discord.deb

# Install Steam
echo "Installing Steam..."
sudo apt install -y steam

# Install Google Chrome
echo "Installing Google Chrome..."
wget -O google-chrome.deb "https://dl.google.com/linux/direct/google-chrome-stable_current_amd64.deb"
sudo apt install -y ./google-chrome.deb
rm google-chrome.deb

# Install Visual Studio Code
echo "Installing Visual Studio Code..."
wget -qO- https://packages.microsoft.com/keys/microsoft.asc | gpg --dearmor > microsoft.gpg
sudo install -o root -g root -m 644 microsoft.gpg /usr/share/keyrings/
sudo sh -c 'echo "deb [arch=amd64 signed-by=/usr/share/keyrings/microsoft.gpg] https://packages.microsoft.com/repos/vscode stable main" > /etc/apt/sources.list.d/vscode.list'
rm microsoft.gpg
sudo apt update
sudo apt install -y code

# Install Python and pip
echo "Installing Python and pip..."
sudo apt install -y python3 python3-pip

# Install Ollama and Llama3 model
echo "Installing Ollama and pulling Llama3 model..."
curl -fsSL https://ollama.com/install.sh | sh
ollama pull llama3

# Install OpenOffice
echo "Installing OpenOffice..."
wget -O openoffice.tar.gz "https://downloads.sourceforge.net/project/openofficeorg.mirror/4.1.13/binaries/en-US/Apache_OpenOffice_4.1.13_Linux_x86-64_install-deb_en-US.tar.gz"
tar -xzf openoffice.tar.gz
cd en-US/DEBS
sudo dpkg -i *.deb
cd desktop-integration
sudo dpkg -i openoffice4.1-debian-menus_4.1.13-9810_all.deb
cd ../../..
rm -rf en-US openoffice.tar.gz

# Install GIMP
echo "Installing GIMP..."
sudo apt install -y gimp

# Install VLC
echo "Installing VLC..."
sudo apt install -y vlc

# Install Blender
echo "Installing Blender..."
sudo apt install -y blender

# Install Dropbox
echo "Installing Dropbox..."
wget -O dropbox.deb "https://www.dropbox.com/download?plat=lnx.x86_64"
sudo apt install -y ./dropbox.deb
rm dropbox.deb

# Install Spotify
echo "Installing Spotify..."
curl -sS https://download.spotify.com/debian/pubkey_5E3C45D7B312C643.gpg | sudo apt-key add -
echo "deb http://repository.spotify.com stable non-free" | sudo tee /etc/apt/sources.list.d/spotify.list
sudo apt update
sudo apt install -y spotify-client

# Announce completion
echo "Installation process completed successfully!"

echo "All requested software has been installed." | tee -a $LOG_FILE
