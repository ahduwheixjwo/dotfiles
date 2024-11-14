# i3wm based on [gruvbox theme](https://github.com/morhetz/gruvbox)
- Distro: [Archlinux](https://archlinux.org)
- Window Manager: [i3wm](https://github.com/i3/i3)
- Bar: [i3blocks](https://github.com/vivien/i3blocks)
- App Launcher: [Rofi](https://github.com/davatorium/rofi)
- Compositor: [Picom](https://github.com/yshui/picom)
- Shell: zsh with [oh-my-zsh](https://github.com/ohmyzsh/ohmyzsh/)
- Terminal: [Kitty](https://github.com/kovidgoyal/kitty)
- Themes: [Gruvbox GTK Theme](https://github.com/Fausto-Korpsvart/Gruvbox-GTK-Theme)
- Icons: [Gruvbox Plus Icon Pack](https://github.com/SylEleuth/gruvbox-plus-icon-pack)

# Installation & Usage
1. You can either clone this repo and manually configure the file.
2. You can run my script _run.sh_ on **fresh Archlinux install**. Feel free to edit the code based on your own usage.
```
git clone https://github.com/ahduwheixjwo/dotfiles.git
cd dotfiles
chmod +x run.sh configuration.sh
./run.sh
./configuration.sh
```
# Screenshot
![Screenshot of the configuration](/screenshots/rice.png)

> [!NOTE]
> _scripts_ folder is my personal script that I use such as automatic update, disable touchscreen and changing resolution. Its not important for the i3wm configuration, but feel free to use it.

> [!IMPORTANT]
> Please note that _run.sh_ is my personal configuration. I didn't use display manager. Instead, I use xinit to manually start my display server. If you want to use it with display manager, you can edit it by yourself.
