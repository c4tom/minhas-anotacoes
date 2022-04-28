[[ -f /usr/sbin/openvpn ]] || { 

   # https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
   ct_openvpn_install() {
      sudo apt install openvpn
   }   
   return ; 
}