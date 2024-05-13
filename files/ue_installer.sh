#!/bin/bash

# Log file
LOG_FILE="unreal_engine_install_results.log"
exec > >(tee -i $LOG_FILE)
exec 2>&1

echo "Starting Unreal Engine installation process..."

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt update && sudo apt upgrade -y

# Install Lutris
echo "Installing Lutris..."
sudo add-apt-repository ppa:lutris-team/lutris -y
sudo apt update
sudo apt install -y lutris

# Install Wine
echo "Installing Wine..."
sudo dpkg --add-architecture i386
sudo apt update
sudo apt install -y wine64 wine32

# Install Winetricks
echo "Installing Winetricks..."
sudo apt install -y winetricks

# Install Epic Games Launcher through Lutris
echo "Installing Epic Games Launcher..."
lutris -i https://lutris.net/api/installers/epic-games-store/installer

# Wait for the user to log into Epic Games Launcher and install Unreal Engine
echo "Please log into the Epic Games Launcher and install Unreal Engine manually."

# Create desktop shortcuts
echo "Creating desktop shortcuts..."

# Create Epic Games Launcher shortcut
cat <<EOF > ~/Desktop/EpicGamesLauncher.desktop
[Desktop Entry]
Name=Epic Games Launcher
Exec=lutris lutris:rungameid/1
Icon=lutris
Type=Application
Categories=Game;
EOF

# Make the shortcut executable
chmod +x ~/Desktop/EpicGamesLauncher.desktop

# Create Unreal Engine shortcut (assuming Unreal Engine is installed in the default location)
cat <<EOF > ~/Desktop/UnrealEngine.desktop
[Desktop Entry]
Name=Unreal Engine
Exec=lutris lutris:rungameid/1
Icon=lutris
Type=Application
Categories=Development;
EOF

# Make the shortcut executable
chmod +x ~/Desktop/UnrealEngine.desktop

echo "Installation process completed successfully!"
echo "Please log into the Epic Games Launcher and install Unreal Engine manually." | tee -a $LOG_FILE
