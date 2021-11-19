#!/bin/sh


ct_isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
}

ct_oracloud_swap() {
   local SIZE_BYTES=${1:-"3145728"}

   cat /proc/sys/vm/swappiness
   sudo sysctl vm.swappiness=10
   sudo dd if=/dev/zero of=/swapfile bs=1024 count=$SIZE_BYTES
   sudo chmod 600 /swapfile

   sudo mkswap /swapfile
   sudo swapon /swapfile

   echo "/swapfile swap swap defaults 0 0" | sudo tee --append /etc/fstab

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

   for i in $1
   do
      sudo firewall-cmd --zone=public --permanent --add-port=$i/tcp
   done
   sudo firewall-cmd --reload
   sudo firewall-cmd --zone=public --list-ports
}
