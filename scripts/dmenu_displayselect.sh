#!/bin/sh
# savage
# detect and select displays
# using xrandr + dmenu
# only two screens supported right now..

twoscreen() { # If multi-monitor is selected and there are two screens

    mirror=$(printf "no\\nyes" | dmenu -i -p "Mirror displays?")
    if [ "$mirror" = "yes" ]; then
	echo "Mirror mode has not been scripted yet. Feel free to do so"        
    else
        primary=$(echo "$screens" | dmenu -i -p "Select primary display:")
        secondary=$(echo "$screens" | grep -v "$primary")
        direction=$(printf "left\\nright" | dmenu -i -p "What side of $primary should $secondary be on?")
        xrandr --output "$primary" --auto --output "$secondary" --"$direction"-of "$primary" --auto 
    fi
    }

morescreen() { # If multi-monitor is selected and there are more than two screens
	primary=$(echo "$screens" | dmenu -i -p "Select primary display:")
	secondary=$(echo "$screens" | grep -v "$primary" | dmenu -i -p "Select secondary display:")
	direction=$(printf "left\\nright" | dmenu -i -p "What side of $primary should $secondary be on?")
	tertiary=$(echo "$screens" | grep -v "$primary" | grep -v "$secondary" | dmenu -i -p "Select third display:")
	xrandr --output "$primary" --auto --output "$secondary" --"$direction"-of "$primary" --auto --output "$tertiary" --"$(printf "left\\nright" | grep -v "$direction")"-of "$primary" --auto
	}

multiscreen() { # Multi-monitor handler.
	case "$(echo "$screens" | wc -l)" in
		1) xrandr $(echo "$allposs" | grep -v "$screens" | awk '{print "--output", $1, "--off"}' | tr '\n' ' ') ;;
		2) twoscreen ;;
		*) morescreen ;;
	esac ;}


# get all connected screens
screens=$(xrandr | grep " connected" | awk '{print $1}')

# prompt user 
chosen=$(printf "%s\\nmulti-monitor" "$screens" | dmenu -i -p "Select display arangement:") &&
case "$chosen" in
	"multi-monitor") multiscreen ;;
	*) xrandr --output "$chosen" --auto $(echo "$screens" | grep -v $chosen | awk '{print "--output", $1, "--off"}');;
esac

pgrep -x dunst >/dev/null && killall dunst && setsid dunst & # Restart dunst to ensure proper location on screen

