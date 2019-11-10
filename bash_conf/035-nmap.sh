[[ -f /usr/bin/nmap ]] || { 
	ct_nmapInstall() {
		sudo apt-get install nmap
	}
	return ; 

}
ct_nmapListaTodosSubDominios() {
	nmap -script dns-brute -v -sn $1;
}

ct_nmapLiveHostOnNetwork() {
    # 192.168.1.1/24
    local IP_NETWORK="$1/24"
    nmap $1 -n -sP | grep report | awk '{print $5}'
}