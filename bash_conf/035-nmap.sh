[[ -f /usr/bin/nmap ]] || { 
	ct_nmap_install() {
		sudo apt-get install nmap
	}
	return ; 

}
ct_nmap_listaTodosSubDominios() {
	nmap -script dns-brute -v -sn $1;
}

ct_nmap_scan_network() {
   : ${1?' <network 192.168.1.0/24>'}

   echo_and_run nmap -sP $1
}

ct_nmap_scan_network_os() {
   : ${1?' <network 192.168.1.0/24>'}

   echo_and_run sudo nmap -sP -0 $1
}

ct_nmap_scan_localhost_ports() {
	local hostip=${1:-"127.0.0.1"};
	nmap --script default $hostip
}