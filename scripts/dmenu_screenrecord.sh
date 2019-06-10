#!/bin/sh
# savage
# screen recording utility
# using ffmpeg and dmenu

#set -x #debugging
#exec > $HOME/dmenu_screen.logo 2>&1 #debugging

prompt() { \
	choice=$(printf "region\nscreen\nkill" |dmenu -p "Select recording style: ")
	case $choice in 
		screen)	record_screen;;
		region)	record_region;;
		kill)	kill_recording;;
	esac
}

# record a specific region
# width = 1366px, height = 330px
# basically, the upper portion of the screen 
# hardcoded to my resolution currently
record_region() { \
	ffmpeg \
	-f x11grab \
	-show_region 1 \
	-r 30 \
	-video_size 1366x330 \
	-i $DISPLAY \
	"$HOME/screencast-$(date '+%y%m%d-%H%M-%S').mkv" > /dev/null 2>&1 & 
	echo $! > /tmp/recording_pid
}

# entire screen
# gets resolution from `xdpyinfo`
record_screen() { \
	ffmpeg \
	-f x11grab \
	-r 30 \
	-s $(xdpyinfo | grep dimensions | awk '{print $2}') \
	-i $DISPLAY \
	"$HOME/screencast-$(date '+%y%m%d-%H%M-%S').mkv" > /dev/null 2>&1 &  
	echo $! > /tmp/recording_pid
}


kill_recording() { \
	killall ffmpeg > /dev/null 2>&1
	rm -f /tmp/recording_pid
}


case "$1" in 
	screen) record_screen;;
	region)	record_region;;
	kill)	kill_recording;;
	*)	([ -f /tmp/recording_pid ] && exit 1) || prompt;;
esac


