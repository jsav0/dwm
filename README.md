# dwm
sav0's fork of the suckless dynamic window manager [(dwm)](https://dwm.suckless.org/)

## General Keybindings
- `Super + Shift + [Enter]` : spawn a terminal [st](https://github.com/jsav0/st)
- `Super + p` : open dmenu
- `Super + Shift + c` : close window
- `Super + Shift + q` : quit dwm
- ... etc

## Custom 
- `Super + Shift + w` : connect to wpa/wpa2 networks via dmenu [(dmenu_wifi.sh)](https://github.com/jsav0/dmenu-scripts/blob/master/dmenu_wifi.sh)
- `Super + Shift + u` : mount a usb drive via dmenu [(dmenu_mountusb.sh)](https://github.com/jsav0/dmenu-scripts/blob/master/dmenu_mountusb.sh)
- `Super + r` : invoke screenrecording via dmenu [(dmenu_record_screen.sh)](https://github.com/jsav0/dmenu-scripts/blob/master/dmenu_record_screen.sh)
  - `Super + Shift + r` : stop screenrecording
- `Super + d` : restart dunst [(dunst)](https://dunst-project.org/)
- `Super + l` : lock screen [(slock)](https://github.com/jsav0/slock-blur) 
- `Super + F12` : opens a quick-select menu of unicode chars and emojis [(dmenu_unicode_symbols.sh)](https://github.com/jsav0/dmenu-scripts/blob/master/dmenu_unicode_symbols.sh)

## Patches (dwm is v6.2)
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

## Dependencies
- xorg
- libX11-devel
- libXft-devel
- libXinerama-devel
- base-devel
- gcc
- make
- git

## Installation
```bash
git clone https://github.com/jsav0/dwm
cd dwm
sudo make clean install
```

