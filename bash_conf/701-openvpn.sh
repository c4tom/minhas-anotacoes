[[ -f /usr/sbin/openvpn ]] || { 

   [[ -f /usr/local/bin/apt ]] || { return ;  }
   # https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
   ct_openvpn_install() {
      sudo apt install openvpn
   }   
   return ; 
}