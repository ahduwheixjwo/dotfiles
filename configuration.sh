#!/bin/bash

set -e
printf '\033e'

printf '\033e'
echo "==> Moving all files to its location..."
sleep 1
cp $PWD/.xinitrc $HOME
cp -r $PWD/.config/* $HOME/.config/

optional() {
    # Change directory to scripts
    cd $PWD/scripts/

    for file in $(ls); do
        if [[ "$file" == "30-touchpad.conf" ]]; then
            sudo cp $file /etc/X11/xorg.conf.d/
        else
            sudo cp $file /usr/local/bin/
        fi
    done

    # Move fonts
    cd $HOME/dotfiles/fonts

    sudo cp -r iosevka /usr/share/fonts/

    # Install essential programs ( Bitwarden & Telegram )
    mkdir $HOME/AppImage

    # Installing Bitwarden & Telegram
    printf '\033e'
    echo "==> Installing Bitwarden..."
    sleep 1

    aria2c -d $HOME/AppImage -o Bitwarden.AppImage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"

    printf '\033e'
    echo "==> Installing Telegram"
    sleep 1

    aria2c -d $HOME/AppImage "https://telegram.org/dl/desktop/linux"

    cd $HOME/AppImage

    chmod +x *.AppImage
    tar -xvf *.tar.xz
    rm *.tar.xz

    # Configure GKT theme and icon packs
    mkdir ~/.local/share/themes
    mkdir ~/.local/share/icons

    cd $HOME/dotfiles/gtk

    # For gtk theme
    bsdtar -xf Gruvbox-Dark-BL.zip -C $HOME/.local/share/themes
    # For icon
    bsdtar -xf gruvbox-plus-icon-pack-5.2.zip -C $HOME/.local/share/themes
}

while true; do
    echo "Do you want to continue with my personal script ? (y/n)
default=n"
    read -p ">>" option

    if [[ -z "$option" || "$option" == "n" || "$option" == "N" ]]; then
        break
    elif [[ "$option" == "y" || "$option" == "Y" ]]; then
        optional
        break
    else
        echo "Invalid option..."
        echo ""
    fi
done

printf '\033e'
echo "==> All configuration has been done. Rebooting..."
sleep 2

reboot