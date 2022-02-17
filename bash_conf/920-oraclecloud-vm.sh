#!/bin/sh


ct_isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
}

ct_oracloud_swap() {
   local SWAP_LOCATION=${1:-"/swapfile"}
   local SIZE_BYTES=${2:-"3145728"}
   cat /proc/sys/vm/swappiness
   sudo sysctl vm.swappiness=10
   sudo dd if=/dev/zero of=$SWAP_LOCATION bs=1024 count=$SIZE_BYTES
   sudo chmod 600 $SWAP_LOCATION

   sudo mkswap $SWAP_LOCATION
   sudo swapon $SWAP_LOCATION

   echo "$SWAP_LOCATION swap swap defaults 0 0" | sudo tee --append /etc/fstab

   sudo swapon --show

   sudo free -h
}

ct_oracloud_install_pacotes() {
   sudo apt install iputils-ping inetutils-telnet firewalld net-tools
}

ct_oracloud_install_cyberPanel() {
   ct_isRoot
   cd /tmp
   sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)
}

ct_oracloud_bash_conf() {
   git clone -b beta --depth 1 --filter=blob:none --no-checkout https://github.com/c4tom/minhas-anotacoes
   cd minhas-anotacoes
   git checkout master -- di
}


ct_oracloud_mariadbServer() {
   apt install mariadb-server
}

ct_oracle_firewalld() {
   : ${1?' <list ports - enclosed by quotes>'}
   : ${2?' zone=(public|docker|????). Ps: get all active zone-> firewall-cmd --get-active-zones'}

   for i in $1
   do
      sudo firewall-cmd --zone=$2 --permanent --add-port=$i/tcp
   done
   sudo firewall-cmd --reload
   sudo firewall-cmd --zone=$2 --list-ports
}
