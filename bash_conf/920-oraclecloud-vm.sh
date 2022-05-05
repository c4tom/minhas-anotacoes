#!/bin/sh


[[ -f /snap/oracle-cloud-agent/36/usr ]] || { return ; }

ct_isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
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
