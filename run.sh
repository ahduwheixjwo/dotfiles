#!/bin/bash

set -e
printf '\033e'

# Update mirrors. (COMMENT IF YOU DON"T WANT THIS)
echo "==> Updating pacman mirrorlist..."
# Check if pacman-contrib is installed...
if [[ ! -f /usr//bin/rankmirrors ]]; then
    sudo pacman -S pacman-contrib
fi

sudo cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
sudo bash -c 'rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist' >/dev/null

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
graphicsPackages="libva lib32-libva libva-intel-driver lib32-libva-intel-driver mesa lib32-mesa vulkan-intel lib32-vulkan-intel"
audioPackages="pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack alsa-utils pavucontrol"
systemPackages="unzip lxappearance acpi thunar firefox usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools shutter zsh code libinput zip libva-utils"
fonts="noto-fonts noto-fonts-cjk noto-fonts-emoji"
yayPackages="picom-git"

echo "==> Installing essential packages..."
sleep 1
sudo pacman -S $xPackages $graphicsPackages $audioPackages $systemPackages $fonts
yay -S $yayPackages

echo "==> Please 'startx' and run ./configuration.sh"
