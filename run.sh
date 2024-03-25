#!/bin/bash

set -e
printf '\033e'

# A variable define to determine whether this script has already run or not
run=false

# Check if this script has already run
if [[ $run==true ]];then
    echo "You've already run this script, please run the configuration. Aborting..."

    sleep 1
    exit 1
fi

# Update mirrors. (COMMENT IF YOU DON"T WANT THIS)
echo "==> Updating pacman mirrorlist..."
# Check if pacman-contrib is installed...
if [[ ! -f /usr//bin/rankmirrors ]]; then
    sudo pacman -S pacman-contrib
fi

# Give root permission if user's doesn't have root permission
if [[ $UID -ne 0 ]]; then
    sudo su
fi

cp /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.backup
rankmirrors -n 6 /etc/pacman.d/mirrorlist.backup > /etc/pacman.d/mirrorlist

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
graphicsPackages="mesa lib32-mesa vulkan-intel lib32-vulkan-intel"
audioPackages="pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack alsa-utils pavucontrol"
systemPackages="usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools ranger shutter zsh code libinput"
fonts="noto-fonts noto-fonts-cjk noto-fonts-emoji ttf-jetbrains-mono-nerd"
yayPackages="brave-bin picom-git"

echo "==> Installing essential packages..."
sleep 1
sudo pacman -S $xPackages $graphicsPackages $audioPackages $systemPackages $fonts
yay -S $yayPackages

echo "==> Please 'startx' and run ./configuration.sh"
run=true