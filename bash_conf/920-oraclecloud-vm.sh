#!/bin/sh
[[ `isWin` != "1" ]] || { return ; }

[[ -f /snap/oracle-cloud-agent/current/agent ]] || { return ; }

ct_isRoot() {
    [[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; kill -INT $$; }
}

ct_oracloud_install_utils_packages() {
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


ct_oracloud_install_mariadbServer() {
   sudo apt update
   sudo apt install mariadb-server
}

ct_oracloud_firewalld_add_rules() {
   : ${1?' <list ports - enclosed by quotes. "80 443 3389 3306">'}
   : ${2?' zone=(public|docker|????). Ps: get all active zone-> firewall-cmd --get-active-zones'}

   for i in $1
   do
      echo_and_run sudo firewall-cmd --zone=$2 --permanent --add-port=$i/tcp
   done
   echo_and_run sudo firewall-cmd --reload
   echo_and_run sudo firewall-cmd --zone=$2 --list-ports
}

ct_oracloud_firewalld_start_enable_service() {
   sudo systemctl start firewalld
   sudo systemctl enable firewalld
}

ct_oracloud_firewalld_listAll() {
   echo_and_run sudo firewall-cmd --list-all
}

# Get all services available
ct_oracloud_firewalld_getServices() {
   echo_and_run sudo firewall-cmd --get-services
}

# install OpenLiteSpeed
ct_oracloud_install_ols() {
   cd /tmp
   wget -O - https://repo.litespeed.sh | sudo bash
   sudo apt update
   sudo apt-get install openlitespeed
   sudo apt-get install lsphp81 lsphp81-common lsphp81-curl lsphp81-mysql lsphp81-opcache lsphp81-imap lsphp81-opcache 

}

# install log/report newRelic for monitoring PHP
ct_oracloud_install_newrelicPHP() {
   echo 'deb http://apt.newrelic.com/debian/ newrelic non-free' | sudo tee /etc/apt/sources.list.d/newrelic.list
   wget -O- https://download.newrelic.com/548C16BF.gpg | sudo apt-key add -
   sudo apt-get update
   sudo apt-get install newrelic-php5 -y
   sudo newrelic-install install

   sudo NR_INSTALL_SILENT=1 newrelic-install install

   #systemctl restart lsws
   #killall lsphp
}