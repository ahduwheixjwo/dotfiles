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

