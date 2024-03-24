#!/bin/bash

set -e
printf '\033e'

# Clone dotfiles repository
echo "==> Cloning dotfiles repository..."
sleep 1
git clone https://github.com/ahduwheixjwo/dotfiles.git && cd dotfiles

printf '\033e'
echo "==> Moving all files to its location..."
sleep 1
cp $PWD/.xinitrc $HOME
cp -r $PWD/.config/ $HOME/.config/


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

    # Install essential programs ( Bitwarden & Telegram )
    mkdir $HOME/AppImage

    # Installing Bitwarden & Telegram
    aria2c -d $HOME/AppImage -o Bitwarden.AppImage "https://vault.bitwarden.com/download/?app=desktop&platform=linux"
    aria2c -d $HOME/AppImage "https://telegram.org/dl/desktop/linux"

    cd $HOME/AppImage

    chmod +x *.AppImage
    tar -xvf *.tar.gz
    rm *.tar.gz
}

while true; do
    echo "Do you want to continue with my personal script ? (y/n)
default=n"
    read -p ">>" option

    if [[ -z "$option" || "$option" == "n" || "$option" == "N" ]]; then
        break
    elif [[ "$option" == "y" || "$option" == "Y" ]]; then
        optional
    else
        echo "Invalid option..."
        echo ""
    fi
done