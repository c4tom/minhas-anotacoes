
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



## Firewall
sudo apt install firewalld
sudo firewall-cmd --zone=public --permanent --add-port=80/tcp
sudo firewall-cmd --reload

sudo firewall-cmd --zone=public --permanent --add-port=7080/tcp
sudo firewall-cmd --reload


sudo firewall-cmd --zone=public --permanent --add-port=3306/tcp
sudo firewall-cmd --reload


sudo firewall-cmd --zone=public --list-ports




# VM OpenLiteSpeed

## Install OpenLiteSpeed

# Se for para ubuntu minimal
sudo apt-get install software-properties-common

sudo su - 

bash <( curl -k https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh )





# VM Mysql

sudo apt update
sudo apt install mysql

# Adicionar usuario

echo "CREATE USER 'cyberpanel'@'10.0.0.%' IDENTIFIED BY 'myr00t@pass'; GRANT ALL ON *.* TO 'cyberpanel'@'10.0.0.%' WITH GRANT OPTION; flush privileges;" | mysql