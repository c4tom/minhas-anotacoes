# Install Open Lite Speed Alma/Oracle Linux

```bash

# https://openlitespeed.org/kb/install-ols-from-litespeed-repositories/
# Oracle Linux 8.6 (02/2023)
# Se necessario, instalar Repository (ol8_developer_EPEL)
# https://www.considerednormal.com/2021/04/installing-epel-release-in-centos-8-and-oracle-linux-8-the-easy-way/


sudo rpm -Uvh --nodeps http://rpms.litespeedtech.com/centos/litespeed-repo-1.1-1.el8.noarch.rpm
sudo yum install epel-release
sudo yum -y install openlitespeed
sudo yum -y install lsphp82 lsphp82-bcmath lsphp82-common lsphp82-gd lsphp82-imap lsphp82-intl lsphp82-ldap lsphp82-mbstring lsphp82-mysqlnd lsphp82-opcache lsphp82-pdo lsphp82-pecl-apcu lsphp82-pecl-imagick lsphp82-pecl-memcached lsphp82-pecl-redis lsphp82-xml lsphp82-zip
sudo yum -y install redis

firewall-cmd --permanent --add-port=7080/tcp
firewall-cmd --permanent --add-port=80/tcp
firewall-cmd --permanent --add-port=443/tcp
firewall-cmd --reload
firewall-cmd --list-ports
```