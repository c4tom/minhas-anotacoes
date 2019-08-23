[[ -f /usr/bin/nmap ]] || { 
	ct_nmapInstall() {
		sudo apt-get install nmap
	}
	return ; 

}
ct_nmapListaTodosSubDominios() {
	nmap -script dns-brute -v -sn $1;
}