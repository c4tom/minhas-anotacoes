[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/sbin/openvpn ]] || { 

   [[ $HASAPT = false ]] && { return; }
   # https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
   ct_openvpn_install() {
      sudo apt install openvpn
   }   
   return ; 
}