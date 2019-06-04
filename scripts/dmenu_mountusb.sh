#!/bin/bash
# savage
# simple script to mount usb drives
# using dmenu
# -- requires root privs (or sudo)

#set -x # debugging
#exec > $HOME/dmenu_mountusb.log 2>&1 # debugging

mount_prep() { \
	MOUNT_POINT=$(find $1 2>/dev/null -maxdepth 5 -type d | dmenu -i -p "Pick a mount point, or type a new one to create it")
	if [ ! -d $MOUNT_POINT ]; then
		MKDIRYN=$(printf "Yes\nNo\nExit" | dmenu -i -p "$MOUNT_POINT does not exist. Create it?")
		case $MKDIRYN in
			[yY]* ) mkdir -p "$MOUNT_POINT" > /dev/null 2>&1 && echo "created directory!" || echo "error";;
			* )	exit 1
		esac
	fi
}

unmount_it() { \
	umount $CHOSEN > /dev/null 2>&1 && notify-send "$CHOSEN unmounted."
}

mount_it() { \
	mount "$CHOSEN" "$MOUNT_POINT" && notify-send "USB $CHOSEN mounted to $MOUNT_POINT."
	exit 1
}


mount_usb() { \
	CHOSEN=$(echo $USB_DEVICES | dmenu -i -p "Mount which drive?" | awk '{print $1}')
	grep "$CHOSEN" /etc/mtab > /dev/null 2>&1 && ALREADY_MOUNTED="YES" || ALREADY_MOUNTED="NO"
	case $ALREADY_MOUNTED in
		YES )	UMOUNTYN=$(printf "No\nYes\nExit" | dmenu -i -p "Device already mounted. Would you like to unmount it?")
			case $UMOUNTYN in
				[yY]* )	unmount_it && exit 0;;
				* )	exit 1;;
			esac;;
		NO )	mount_prep "/mnt /media";; # add regular mountpoints here
		* )	exit 1;;
	esac
	if [ -d $MOUNT_POINT ]; then
		mount_it
	else
		exit 1
	fi
}


USB_DEVICES=$(lsblk -rpo "hotplug,type,name,size" | awk '$1=="1"&&$2=="part" {printf "%s (%s)\n",$3,$4}')
if [ "$USB_DEVICES" ]; then
	mount_usb
else
	echo "exit" | dmenu -p "Sorry, no USB disks were detected"
	exit 1
fi
