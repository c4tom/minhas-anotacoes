[[ -f /usr/bin/create_ap ]] || { return ; }

# https://unix.stackexchange.com/questions/340799/wifi-repeater-with-a-single-wifi-adapter-in-debian
# https://github.com/oblique/create_ap

# instalar também (apt-get install hostapd haveged)


wifiRepeater() {
	local ssid=$1
	local pass=$2

	if [ -z $ssid ] 
		then
			echo "Informe o SSID:"
			read ssid
			echo "Informe a senha:"
			read pass
		fi

	#local ifaceWIFI=$(ifconfig | grep wlx | awk '{ print $1 }' | sed 's/://')
	local ifaceWIFI="$(iw dev | awk '$1=="Interface"{print $2}')"
	local ifaceWithInternet=$(route -n | grep UG | head -n 1 | awk '{print $8}')
	#local mac=$(echo "`ct_rand0_99`:`ct_rand0_99`:`ct_rand0_99`:`ct_rand0_99`:`ct_rand0_99`:`ct_rand0_99`")
	local mac=`__macAddrGen`
	local channel=`ct_rand 1 11`

	echo "create_ap -c $channel -dd --mac $mac $ifaceWIFI $ifaceWithInternet $ssid $pass $3 $4 $5"
	create_ap -c $channel -dd --mac $mac $ifaceWIFI $ifaceWithInternet $ssid $pass $3 $4 $5
}

wifi2wifiTransmiter() {
	local ssid=$1
	local pass=$2

	if [ -z $ssid ] 
		then
			echo "Informe o SSID:"
			read ssid
			echo "Informe a senha:"
			read pass
		fi

	local ifaceWIFI="$(iw dev | awk '$1=="Interface"{print $2}')"
	local mac=`__macAddrGen`
	local channel=`ct_rand 1 11`

	echo "create_ap -c $channel -dd --mac $mac $ifaceWIFI $ifaceWIFI $ssid $pass $3 $4 $5"
	create_ap -c $channel -dd --mac $mac $ifaceWIFI $ifaceWIFI $ssid $pass $3 $4 $5
}

ct_wifiRepeaterListarClientes(){
	local hapID=`create_ap --list-running | grep ^[0-9] | awk -F' ' '{print $1}'`

	create_ap --list-clients $hapID
}
