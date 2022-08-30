
[[ `isWin` != "1" ]] || { return ; }


[[ -f /usr/bin/convert ]] || { 
	ct_convert_install() {
		sudo apt install nmap
	}
	return ; 
}

ct_image_quality() {
   : ${1?' <img path/name in'}
   : ${2?' <img path/name out'}
	: ${3?' <quality 1-100>'}
   echo_and_run convert -quality "$3" "$1" "$2"
}