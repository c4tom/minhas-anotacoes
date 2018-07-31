


# Docker Images

ver também: https://github.com/docker-library/docs/

## Minhas Imagens Testadas

- Banco Oracle
```bash

# https://hub.docker.com/r/wnameless/oracle-xe-11g/
docker pull wnameless/oracle-xe-11g

docker run -d -p 49160:22 -p 49161:1521 wnameless/oracle-xe-11g
```
**hostname**: localhost
**port**: 49161
**sid**: xe
**username**: system
**password**: oracle
**URL JDBC**:  jdbc:oracle:thin:@localhost:49161/xe

Password for SYS & SYSTEM

**Login by SSH**
ssh root@localhost -p 49160
password: admin


## Elastics Search
 - https://github.com/blacktop/docker-elasticsearch-alpine
 - Opções: https://github.com/blacktop/docker-elasticsearch-alpine/blob/master/docs/options.md

Instalação: `docker run -d --name elastic -p 9200:9200 blacktop/elasticsearch:latest`


Obs: nas versão 5.x do elasticsearch, precisa executar no linux

sudo sysctl -w vm.max_map_count=262144

## Eclipse CHE

http://www.eclipse.org/che/

https://www.eclipse.org/che/docs/setup/getting-started/

https://www.eclipse.org/che/docs/setup/cli/index.html


Obs: somente no linux

Crie um diretorio '/home/docker/eclipse-che'

adicione um **start.sh**, crie uma pasta **data**
```bash
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/data:/data eclipse/che start --fast
```

```bash

# Interactive help
docker run -it eclipse/che start

# Or, full start syntax where <path> is a local directory (criar a pasta data no diretorio aonde esta executando o comando
docker run -it --rm -v /var/run/docker.sock:/var/run/docker.sock -v `pwd`/data:/data eclipse/che start


# Todos dockers abaixo serão instalados, e outros serão instalados com o uso da aplicação
REPOSITORY           TAG                 IMAGE ID            CREATED             SIZE
eclipse/che          latest              8b93584e6d0a        8 days ago          51.2 MB
eclipse/che-server   5.11.2              c6bdf74ede84        8 days ago          310 MB
alpine               3.4                 6008ce38ddc1        11 days ago         4.81 MB
eclipse/che-init     5.11.2              0e10c068af0f        2 weeks ago         55 MB
traefik              v1.3.0-rc1          74cd77a07e38        4 weeks ago         45 MB
eclipse/che-ip       5.11.2              2ec54bd84956        5 weeks ago         4.81 MB
docker/compose       1.8.1               5edc87ec4325        8 months ago        59.2 MB

# Veja o status
docker container ls
CONTAINER ID        IMAGE                       COMMAND             CREATED             STATUS              PORTS                              NAMES
4e333b57e9db        eclipse/che-server:5.11.2   "/entrypoint.sh"    2 minutes ago       Up 2 minutes        8000/tcp, 0.0.0.0:8080->8080/tcp   che


# Ver o log
docker container logs 4e333b57e9db
ou
docker logs -f che

```