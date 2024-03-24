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

# This will move all my personal script is scripts direcotry. Comment to stop this action
# Change directory to scripts
cd $PWD/scripts/

for file in $(ls); do
    if [[ "$file" == "30-touchpad.conf" ]]; then
        sudo cp $file /etc/X11/xorg.conf.d/
    else
        sudo cp $file /usr/local/bin/
    fi
done
