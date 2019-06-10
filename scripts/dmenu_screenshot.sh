#!/bin/sh
# savage
# screenshot utility 
# using maim and dmenu

prompt() { \
	CHOICE=$(printf "region\nfull\nexit" | dmenu -p "Select screenshot type: ")
	case $CHOICE in 
		region) maim -s > /tmp/ss.png ;;
		full) ;;
		*) exit 0;;
	esac
}

case "$1" in 
	*) prompt;;
esac

