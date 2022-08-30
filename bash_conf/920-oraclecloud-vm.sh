#!/bin/sh
[[ `isWin` != "1" ]] || { return ; }

[[ -f /snap/oracle-cloud-agent/current/agent ]] || { return ; }

ct_isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
}

ct_oracloud_install_pacotes() {
   sudo apt install iputils-ping inetutils-telnet firewalld net-tools bash-completion
}

ct_oracloud_install_cyberPanel() {
   ct_isRoot
   cd /tmp
   sh <(curl https://cyberpanel.net/install.sh || wget -O - https://cyberpanel.net/install.sh)
}


# primeira vez, copie e cole esta funcao no terminal/bash
ct_oracloud_bash_conf() {
   git clone -b beta --depth 1 --filter=blob:none --no-checkout https://github.com/c4tom/minhas-anotacoes
   cd minhas-anotacoes
   git checkout master -- di
}


ct_oracloud_mariadbServer() {
   sudo apt update
   sudo apt install mariadb-server
}

ct_oracle_firewalld() {
   : ${1?' <list ports - enclosed by quotes>'}
   : ${2?' zone=(public|docker|????). Ps: get all active zone-> firewall-cmd --get-active-zones'}

   for i in $1
   do
      echo_and_run sudo firewall-cmd --zone=$2 --permanent --add-port=$i/tcp
   done
   echo_and_run sudo firewall-cmd --reload
   echo_and_run sudo firewall-cmd --zone=$2 --list-ports
}

ct_oracle_firewalld_listAll() {
   echo_and_run sudo firewall-cmd --list-all
}

ct_oracle_firewalld_getServices() {
   echo_and_run sudo firewall-cmd --get-services
}

ct_oracle_install_ols() {
   cd /tmp
   wget -O - https://repo.litespeed.sh | sudo bash
   sudo apt update
   sudo apt-get install openlitespeed
   sudo apt-get install lsphp81 lsphp81-common lsphp81-curl lsphp81-mysql lsphp81-opcache lsphp81-imap lsphp81-opcache 

}