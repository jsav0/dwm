# dwm
sav0's fork of the suckless dynamic window manager [(dwm)](https://dwm.suckless.org/)

## Keybindings
- `Super + Shift + [Enter]` : spawn a terminal [st](https://github.com/jsav0/st)
- `Super + p` : open dmenu
- `Super + Shift + c` : close window
- `Super + Shift + q` : quit dwm
- ... etc

## Patches (dwm updated to 6.2)
- [Fancybar](https://dwm.suckless.org/patches/fancybar/)
  - this patch provides a status bar that shows the titles of all visible windows (as opposed to showing just the selected one)
- [Gridmode](https://dwm.suckless.org/patches/gridmode/)
  - this patch adds an extra layout mode to dwm called **grid** 
  - `Super + g` : set grid mode
- [Fullgaps](https://dwm.suckless.org/patches/fullgaps/)
  - this patch adds inner and outer gaps to client windows 
  - `Super + [-]` : decrease gaps 
  - `Super + [=]` : increase gaps
  - `Super + Shift + [=]` : sets gaps to zero
  - the variable `gappx` contains the default gap size in the configuration file


## Installation
```bash
git clone https://github.com/jsav0/dwm
cd dwm
sudo make clean install
```

