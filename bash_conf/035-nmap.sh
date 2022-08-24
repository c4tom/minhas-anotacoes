[[ `isWin` == "1" ]] || { return ; }

[[ -f /usr/bin/nmap ]] || { 
	[[ $HASAPT = false ]] && { return; }
	ct_nmap_install() {
		sudo apt-get install nmap
	}
	return ; 

}
ct_nmap_listaTodosSubDominios() {
	nmap -script dns-brute -v -sn $1;
}

ct_nmap_scan_network() {
	echo Router is: $(route -n | grep 0.0.0.0 | head -n 1 | awk '{print $2}')
   : ${1?' <network 192.168.1.0/24>'}

   echo_and_run nmap -sP $1
}

alias scanIPs=ct_nmap_scan_network

ct_nmap_scan_network_os() {
   : ${1?' <network 192.168.1.0/24>'}

   echo_and_run sudo nmap -sT -O $1
}

ct_nmap_scan_localhost_ports() {
	local hostip=${1:-"127.0.0.1"};
	nmap --script default $hostip
}