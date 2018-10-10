[[ -f /usr/bin/create_ap ]] || { return ; }

# https://unix.stackexchange.com/questions/340799/wifi-repeater-with-a-single-wifi-adapter-in-debian
# https://github.com/oblique/create_ap

wifiRepeater() {
	local ssid=$1
	local pass=$2
 create_ap wlp2s0 wlp2s0 $ssid $pass
}