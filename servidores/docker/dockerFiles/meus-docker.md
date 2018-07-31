Veja também: http://github.com:c4tom/mydockers.git



## ORACLE X11 XE
docker run --name oracleXE-11G -d -p 49160:22 -p 49161:1521 -p 58080:58080 -e ORACLE_DISABLE_ASYNCH_IO=true wnameless/oracle-xe-11g

username: system
password: oracle


docker run --name elasticsearch -d -p 9200:9200 bitnami/elasticsearch:latest

docker run --name bitnami-mysql -e ALLOW_EMPTY_PASSWORD=yes bitnami/mysql:latest

docker run --name bitnami-mariadb -e ALLOW_EMPTY_PASSWORD=yes -v bitnami:/bitnami bitnami/mariadb:latest

docker run --name bitnami-postgresql -v postgres:/bitnami bitnami/postgresql:latest

docker run --name wildfly -p 8080:8080 -p 9990:9990 -v /d/temp:/bitnami bitnami/wildfly:latest

cd /caminho/de/um/projeto
curl -LO https://raw.githubusercontent.com/bitnami/bitnami-docker-symfony/master/docker-compose.yml
docker-compose up

curl -sSL https://raw.githubusercontent.com/bitnami/bitnami-docker-opencart/master/docker-compose.yml > docker-compose.yml


## Samba 4 com Domain Controler
docker run -d --restart unless-stopped \
    -e SAMBA_DC_REALM='apocalipse.nt' \
    -e SAMBA_DC_DOMAIN='apocalipse' \
    -e SAMBA_DC_ADMIN_PASSWD='t3ll7hew0rld!' \
    -e SAMBA_DC_DNS_BACKEND='SAMBA_INTERNAL' \
    -v ${PWD}/samba:/samba \
     'laslabs/alpine-samba-dc:0.1.0'


## MSSQL Express
https://docs.microsoft.com/pt-br/sql/linux/quickstart-install-connect-docker?view=sql-server-linux-2017

docker run --name mssql_express -e 'ACCEPT_EULA=Y' -e 'SA_PASSWORD=#PaSSword!123' -e 'MSSQL_PID=Express' -p 1433:1433 -d microsoft/mssql-server-linux:latest

**Logar na maquina com bash**
docker exec -it mssql_express "bash"

