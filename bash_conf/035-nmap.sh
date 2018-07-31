
ct_nmapListaTodosSubDominios() {
	nmap -script dns-brute -v -sn $1;
}