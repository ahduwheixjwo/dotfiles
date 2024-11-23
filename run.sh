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
pipewirePackages="lib32-libpulse libpulse pipewire-pulse pipewire-alsa pavucontrol alsa-utils bluez bluez-libs bluez-utils"
pulseaudioPackages="lib32-libpulse libpulse pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pavucontrol alsa-utils bluez bluez-libs bluez-utils"
systemPackages="unzip lxappearance acpi thunar firefox usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools shutter zsh code libinput p7zip libva-utils picom"
fonts="noto-fonts noto-fonts-cjk noto-fonts-emoji"

while true; do
    echo "Choose your audio server (1- pulse, 2- pipewire)"
    read -p ">>" audio_server

    if [[ -z "$audio_server" || "$audio_server" == "1" ]]; then
        sudo pacman -S $xPackages $graphicsPackages $pulseaudioPackages $systemPackages $fonts
        break
    elif [ "$audio_server" == "2" ]; then
        sudo pacman -S $xPackages $graphicsPackages $pipewirePackages $systemPackages $fonts
        break
    else
        echo "Invalid option..."
        echo ""
    fi
done

sudo systemctl enable bluetooth > /dev/null
sudo systemctl start bluetooth

cp .xinitrc $HOME

echo "==> Please 'startx' and run ./configuration.sh"
sleep 2
