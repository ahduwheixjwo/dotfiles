#!/bin/bash

set -e
printf '\033e'

printf '\033e'
echo "==> Moving all files to its location..."
sleep 1
cp $PWD/.xinitrc $HOME
cp -r $PWD/.config/* $HOME/.config/
sudo cp -r $PWD/Fonts/iosevka /usr/share/fonts
sudo cp -r $PWD/Fonts/JetBrainsMono /usr/share/fonts

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
