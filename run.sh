#!/bin/bash

set -e
printf '\033e'

# Check if git is installed
if [[ ! -f /usr/bin/git ]]; then
    sudo pacman -S git

# Check if .cache folder existed
if [[ ! -d $HOME/.cache ]]; then
    mkdir .cache

echo "==> Installing yay ( AUR Helper)..."
sleep 1
# Install yay in .cache folder
cd $HOME/.cache && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si

printf '\033e'
# Install essential packages
xPackages="xorg-server xorg-xinit xorg-xrandr xorg-xinput"
graphicsPackages="mesa lib32-mesa vulkan-intel lib32-vulkan-intel"
audioPackages="pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack alsa-utils pavucontrol"
systemPackages="usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools ranger shutter zsh code"
fonts="noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono-nerd"
yayPackages="brave-bin picom-git"

echo "==> Installing essential packages..."
sleep 1
sudo pacman -S $xPackages $graphicsPackages $audioPackages $systemPackages $fonts
yay -S $yayPackages

source $PWD/configuration.sh

printf '\033e'
echo "==> All configuration has been done. Rebooting..."
sleep 1.5

reboot