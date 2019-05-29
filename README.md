# dwm
savage's fork of the suckless dynamic window manager [(dwm)](https://dwm.suckless.org/)

## General Keybindings
- `Super + Shift + [Enter]` : spawn a terminal [st](https://github.com/jsav0/st)
- `Super + p` : open dmenu
- `Super + Shift + c` : close window
- `Super + Shift + q` : quit dwm
- ... etc

## Other Keybindings (with dmenu interaction)
- `Super + Shift + w` : connect to wireless networks [dmenu_wifi.sh](https://github.com/jsav0/dmenu-scripts)
- `Super + r` : starts screen recording [dmenu_record-screen.sh](https://github.com/jsav0/dmenu-scripts)
- `Super + Shift + r` : stops screen recording [dmenu-record-screen.sh](https://github.com/jsav0/dmenu-scripts)


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

