[[ -f /usr/bin/create_ap ]] || { return ; }

# https://unix.stackexchange.com/questions/340799/wifi-repeater-with-a-single-wifi-adapter-in-debian
# https://github.com/oblique/create_ap

wifiRepeater() {
	local ssid=$1
	local pass=$2
	local ifaceWIFI=$(ifconfig | grep wlp | awk '{ print $1 }')
	local ifaceWithInternet=$(route | grep default | awk '{print $8}')
 create_ap $ifaceWIFI $ifaceWithInternet $ssid $pass
}