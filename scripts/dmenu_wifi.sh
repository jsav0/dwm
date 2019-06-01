#!/bin/bash
# savage
# quick scan and connect for wireless networks
# via dmenu
# Notes:
# -- very little error handling exists
# -- only WPA/WPA2 with DHCP is supported right now
# -- need to add support for open networks w/ captive portals

#set -x # debugging
#exec > $HOME/dmenu_wifi.log 2>&1 # debugging

# select wireless interface
select_interface() { \
	INTFC_LIST=$(iw dev | grep Interface | grep wl | awk '{print $2}')
	INTFC="$(printf "exit\\n$INTFC_LIST" | dmenu -l 15 -p "Chose a wireless interface: " )"
	[ $(echo $INTFC | awk '{print $1}') == "exit" ] && exit 1 
}


# scan for nearby hotspots using `wpa_cli`
scan_for_ssid() { \
	AP_LIST=$(wpa_cli scan >/dev/null && wpa_cli scan_results | column -t | \
	tail -n +3 | sort -k3 -n -r | awk '{print}') 
	SSID=$(printf "exit\nrescan\n$AP_LIST" | dmenu -l 30 -p "Select a nearby network: ")
	RESULT=$(echo $SSID | awk '{print $1}')
	case $RESULT in
		exit )		exit 1;;
		rescan )	scan_for_ssid;;
		*) 		SSID=$(echo $SSID |  awk '{ for (i=5; i<=NF; i++) \
				printf("%s ", $i) }END{ print"" }' | sed 's/ *$//')
	esac
}

# if the wireless AP does not have an accompanying WPA / WEP key 
# but has a captive portal instead, this should work
# Note: this is a one time connection and will not save the network
connect_to_open_network() { \
	iw dev $INTFC connect -w "$SSID"
	dhcpd $INTFC
}


# will not return error if pre shared key is wrong
# passphrase must be between 8..64 characters,
# but there is no validation
configure_wpa_network() { \
	CONTINUE=$(echo -e "yes\nno\nexit" | dmenu -p "Configure WPA with PSK? (y or n)")
	case $CONTINUE in
		[yY]* )	\
			PSK=$(echo -e | dmenu -p "Enter WPA/WPA2 Key: " | awk '{print}')
			wpa_passphrase "$SSID" "$PSK" | sudo tee -a /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf > /dev/null 2>&1
			wpa_cli reconfigure > /dev/null 2>&1;;
		* )	exit 1;;
	esac
}

# check if network configuration already exists
# if so, prompt user to select existing config
# or create new using configure_wpa_network
is_network_known() { \
	grep "$SSID" /etc/wpa_supplicant/wpa_supplicant-$INTFC.conf > /dev/null && KNOWN=YES || KNOWN=NO
	if [ $KNOWN == "NO" ] ; then
		# connect_to_open_network()
		configure_wpa_network
	fi
}

new_network() { \
	select_interface
	scan_for_ssid
	configure_wpa_network
}



load_network() { \
	ID=$(wpa_cli list_networks | column -t | \
	tail -n +3 | dmenu -l 100 -p \
	"Chose a configuration to load: (or type X to close)" | awk '{print $1}')
	case $ID in
		x|X )	exit 1;;
		* )	wpa_cli select_network $ID > /dev/null 2>&1;;
	esac
}


load() { \
	choice=$(echo -e "y\nn\nexit" | \
	dmenu -p "Load existing wireless profile? (y or n)")
	case $choice in
		[yY]* )	load_network;;
		* )	exit 1;;
	esac
}


prompt() { \
	DO=$(echo -e "Connect to a new wireless network\nLoad existing wireless profile" \
	| dmenu -p "What do you want to do?" | awk '{print $1}')
	case $DO in
		Connect )	new_network;;
		Load	)	load;;
		* )		exit 1;;
	esac
}


## -- INITIAL CASE -- ##
case "$1" in
	new )	new_network;;
	load )	load;;
	* )	prompt;;
esac

