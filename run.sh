#!/bin/bash

set -e
printf '\033e'

echo "==> Checking and updating mirrors with reflector..."
if ! command -v reflector &> /dev/null; then
    sudo pacman -S --needed reflector
fi
sudo reflector --verbose --sort rate -l 20 -c Singapore --save /etc/pacman.d/mirrorlist
sudo pacman -Sy

# Check if git and base-devel are installed (needed for yay)
if ! command -v git &> /dev/null || ! pacman -Qi base-devel &> /dev/null; then
    echo "==> Installing git and base-devel..."
    sudo pacman -S --needed git base-devel
fi

# Check if .cache folder existed
if [[ ! -d "$HOME/.cache" ]]; then
    mkdir -p "$HOME/.cache"
fi

if ! command -v yay &> /dev/null; then
    echo "==> Installing yay (AUR Helper)..."
    sleep 1
    # Install yay in .cache folder
    cd "$HOME/.cache" && git clone https://aur.archlinux.org/yay.git && cd yay && makepkg -si
else
    echo "==> yay is already installed."
fi

printf '\033e'
# Install essential packages
xPackages=(xorg-server xorg-xinit xorg-xrandr xorg-xinput)
intelGraphicsPackages=(mesa lib32-mesa intel-media-driver vulkan-intel lib32-vulkan-intel)
amdGraphicsPackages=(mesa lib32-mesa vulkan-radeon lib32-vulkan-radeon)
pipewirePackages=(lib32-libpulse libpulse pipewire-pulse pipewire-alsa pavucontrol alsa-utils bluez bluez-libs bluez-utils)
pulseaudioPackages=(lib32-libpulse libpulse pulseaudio pulseaudio-alsa pulseaudio-bluetooth pulseaudio-jack pavucontrol alsa-utils bluez bluez-libs bluez-utils)
systemPackages=(unzip lxappearance acpi thunar firefox usbutils brightnessctl feh i3-gaps i3blocks rofi kitty xwallpaper aria2 android-tools shutter zsh code libinput p7zip libva-utils picom)
fonts=(noto-fonts noto-fonts-cjk noto-fonts-emoji)

while true; do
    echo "Choose your graphics (1- Intel, 2- AMD)"
    read -p ">>" graphics_choice

    if [[ -z "$graphics_choice" || "$graphics_choice" == "1" ]]; then
        selectedGraphics=("${intelGraphicsPackages[@]}")
        break
    elif [ "$graphics_choice" == "2" ]; then
        selectedGraphics=("${amdGraphicsPackages[@]}")
        break
    else
        echo "Invalid option..."
        echo ""
    fi
done

while true; do
    echo "Choose your audio server (1- pulse, 2- pipewire)"
    read -p ">>" audio_server

    if [[ -z "$audio_server" || "$audio_server" == "1" ]]; then
        selectedAudio=("${pulseaudioPackages[@]}")
        break
    elif [ "$audio_server" == "2" ]; then
        selectedAudio=("${pipewirePackages[@]}")
        break
    else
        echo "Invalid option..."
        echo ""
    fi
done

echo "==> Installing packages..."
sudo pacman -S --needed "${xPackages[@]}" "${selectedGraphics[@]}" "${selectedAudio[@]}" "${systemPackages[@]}" "${fonts[@]}"

cp .xinitrc "$HOME"

echo "==> Please 'startx' and run ./configuration.sh"
sleep 2
