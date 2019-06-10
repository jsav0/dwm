# dmenu-scripts
savage's dmenu scripts
<small>these scripts are integrated into my fork of [dwm](https://github.com/jsav0/dwm)</small>

## dmenu_wifi.sh
this script aims to make the command-line configuration of wireless networks a bit easier with the use of `dmenu`
- only WPA/WPA2 with DHCP is supported right now
- manage wireless networks with dmenu
- very little error handling exists
- future update to include support for open networks w/ captive portals (i.e. hotels, restaraunts, free hotspots, etc)
- Keybinding in my dwm config,
  - `Super + Shift + w` : executes this script
- <small> this script is not complete, contributions are welcome</small>

---

## dmenu_record_screen.sh
this script can initiate screen recordings of a specifc region or the entire screen using `dmenu`
- start/stop screen recordings with dmenu 
- video only, no audio yet
- Keybinding in my dwm config, 
  - `Super + r` : starts the recording
  - `Super + Shift + r` : kills the recording

---

## dmenu_mountusb.sh
simple interactive script to mount USB drives via dmenu
- Keybinding in my dwm config,
  - `Super + Shift + u` : invokes the script

---

## dmenu_displayselect
simple script to detect and select mutliple monitors
- uses xrandr + dmenu 
- select a single display or multiple displays and define orientation w.r.t each other
- does not support Mirror mode, yet
- Keybinding in my dwm config,
  - `Super + F12`
