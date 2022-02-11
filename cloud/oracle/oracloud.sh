
ct_docker_install_DockerCE() {
	export $(cat /etc/os-release | grep UBU)
	local UBUNTU_RELEASE=$UBUNTU_CODENAME
	sudo apt-get remove docker docker-engine docker.io containerd runc
	sudo apt-get install apt-transport-https ca-certificates curl gnupg-agent software-properties-common
	curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
	sudo apt-key fingerprint 0EBFCD88
	sudo add-apt-repository "deb https://download.docker.com/linux/ubuntu $UBUNTU_RELEASE stable"
	sudo apt-get update
	sudo apt-get install docker-ce docker-ce-cli containerd.io

	sudo usermod -a -G docker $USER
}


## Criar chaves ssh

ssh-keygen -t rsa -N "" -b 4096 -C "" -f ~/.ssh/id_rsa_oracloud ; cat ~/.ssh/id_rsa_oracloud.pub




sudo firewall-cmd --zone=public --list-ports




# VM OpenLiteSpeed

## Install OpenLiteSpeed

# Se for para ubuntu minimal
sudo apt-get install software-properties-common

# Instalar Pacotes
apt install firewalld mariadb-client-core-10.3 net-tools

# Setando firewall
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp # http
sudo firewall-cmd --zone=public --permanent --add-port=443/tcp # https
sudo firewall-cmd --zone=public --permanent --add-port=7080/tcp # OLS
sudo firewall-cmd --reload

# ao reiniciar VM
service firewalld restart

sudo su - 

wget https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh && bash ols1clk.sh


# para obter a senha do admin /usr/local/lsws/adminpasswd

# https://docs.litespeedtech.com/products/lsmcd/getting_started/
install_lsmcd() {
	sudo apt-get install git build-essential zlib1g-dev libexpat1-dev openssl libssl-dev libsasl2-dev libpcre3-dev -y
	cd /tmp
	git clone https://github.com/litespeedtech/lsmcd.git
	cd lsmcd
	./fixtimestamp.sh
	./configure CFLAGS=" -O3" CXXFLAGS=" -O3"
	make
	sudo make install
	sudo chown -R ubuntu /usr/local/lsmcd
	sudo systemctl enable lsmcd
	sudo systemctl start lsmcd

	sudo apt install 
}

# https://openlitespeed.org/kb/lets-encrypt-ssl-on-openlitespeed/
install_lets_encrypt() {
	
}



# VM Mysql

sudo apt update
sudo apt install mariadb-server firewalld vim net-tools

#sudo firewall-cmd --zone=public --permanent --add-port=3306/tcp
#sudo firewall-cmd --reload

sudo firewall-cmd --new-zone=mysqlzone --permanent
sudo firewall-cmd --reload
sudo firewall-cmd --permanent --zone=mysqlzone --add-source=10.0.0.0/24
sudo firewall-cmd --permanent --zone=mysqlzone --add-port=3306/tcp
sudo firewall-cmd --reload

# Adicionar usuario

echo "CREATE USER 'olspanel'@'localhost' IDENTIFIED BY 'myr00t@pass'; GRANT ALL ON *.* TO 'olspanel'@'localhost' WITH GRANT OPTION; flush privileges;" | mysql
echo "CREATE USER 'olspanel'@'vm_mqaaf-ols' IDENTIFIED BY 'myr00t@pass'; GRANT ALL ON *.* TO 'olspanel'@'vm_mqaaf-ols' WITH GRANT OPTION; flush privileges;" | mysql


sed -i "s#127.0.0.1#0.0.0.0#" /etc/mysql/mariadb.conf.d/50-server.cnf
