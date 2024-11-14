#!/bin/bash

set -e
printf '\033e'

# Check if git is installed
if [[ ! -f /usr/bin/git ]]; then
    sudo pacman -S git
fi

# Check if .cache folder existed
if [[ ! -d $HOME/.cache ]]; then
    mkdir $HOME/.cache
fi

echo "==> Installing yay ( AUR Helper)..."
sleep 1
# Install yay in .cache folder
cd $HOME/.cache && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

printf '\033e'
# Install essential packages
xPackages="xorg-server xorg-xinit xorg-xrandr xorg-xinput"
graphicsPackages="mesa lib32-mesa intel-media-driver vulkan-intel lib32-vulkan-intel"
audioPackages="lib32-libpulse libpulse pipewire-pulse pipewire-alsa pavucontrol bluez bluez-libs bluez-utils"
systemPackages="unzip lxappearance acpi thunar firefox usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools shutter zsh code libinput zip libva-utils"
fonts="noto-fonts noto-fonts-cjk noto-fonts-emoji"
yayPackages="picom-git"

echo "==> Installing essential packages..."
sleep 1
sudo pacman -S $xPackages $graphicsPackages $audioPackages $systemPackages $fonts
yay -S $yayPackages

sudo systemctl enable bluetooth > /dev/null
sudo systemctl start bluetooth

cp $PWD/.xinitrc $HOME

echo "==> Please 'startx' and run ./configuration.sh"
sleep 2
