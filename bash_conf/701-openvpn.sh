[[ -f /usr/sbin/openvpn ]] || { 

   # https://community.openvpn.net/openvpn/wiki/OpenVPN3Linux
   ct_openvpn_install() {
      cd /tmp
      sudo apt install apt-transport-https
      wget https://swupdate.openvpn.net/repos/openvpn-repo-pkg-key.pub
      sudo apt-key add openvpn-repo-pkg-key.pub

      local DISTRO="focal"

      wget -O /etc/apt/sources.list.d/openvpn3.list https://swupdate.openvpn.net/community/openvpn3/repos/openvpn3-$DISTRO.list
      sudo apt update

      sudo apt install openvpn3
   }   
   
   
   return ; 
}