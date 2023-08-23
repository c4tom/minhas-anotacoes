[[ -f /usr/bin/docker ]] || { return; }

DOCKER_X11="/tmp/.X11-unix:/tmp/.X11-unix"
DOCKER_DISPLAY="DISPLAY=unix$DISPLAY"

DOCKER_X11_SHORT="$DOCKER run -ti --rm -v $DOCKER_X11 -e $DOCKER_DISPLAY --device /dev/dri --net=host"

ct_docker_XApp_VisualStudioCodePHP() {
    # Execute na pasta aonde quer o document_root
    local RAND=$(ct_rand0_999)
    $DOCKER_X11_SHORT -v "$PWD":/var/www/html --name vscode$RAND insready/vscode-php
}

ct_docker_XApp_SublimeText3() {
    # Execute na pasta aonde quer o document_root
    local RAND=$(ct_rand0_999)
    $DOCKER_X11_SHORT -v "$PWD":/home --name sublime$RAND jess/sublime-text-3
}

ct_docker_XApp_LXDEWine() {
    $DOCKER_X11_SHORT --name lxdewine$RAND x11docker/lxde-wine
}
ct_docker_XApp_XFCEWine() {
    $DOCKER_X11_SHORT --name lxdewine$RAND x11docker/xfce-wine-playonlinux
}

ct_docker_XApp_DBSchema() {
    $DOCKER_X11_SHORT --name dbschema$RAND amcorreia/docker-dbschema
}

ct_docker_XApp_CrossOver() {
    $DOCKER_X11_SHORT --name crossover$RAND crossover:latest
}
ct_docker_XApp_Kitematic() {
    $DOCKER_X11_SHORT --name crossover$RAND --privileged=true jonadev95/kitematic-docker
}

## Utils docker pronto
DOCKER_NET_DEV=develop

ct_docker_ServerApp_MariaDB() {
    ct_docker_network_createDevelop
    
    local ROOT_PASSWORD=${1:-"senhasenha"}
    local PORT_TO_LISTEN=${2:-"3306"}
    
    echo_and_run $DOCKER run -d --name mariadb-server-develop \
    --network $DOCKER_NET_DEV \
    -e MYSQL_ROOT_PASSWORD=$ROOT_PASSWORD \
    -v "/home/docker/mysql/bancodedados":/var/lib/mysql \
    -v "/home/docker/mysql/dump":/dump \
    -p $PORT_TO_LISTEN:3306 \
    mariadb:latest
}

ct_docker_ServerApp_ApachePhp56() {
    HELPTXT="
    
    ${FUNCNAME[0]} <docker_name> <path> <port_to_listen> [<network>(default:$DOCKER_NET_DEV)]"
    ct_help $1
    
    : ${1?' docker_name'}
    : ${2?' path'}
    : ${3?' port_to_listen'}
    
    local DOCKER_NAME=$1
    local LOCAL_PATH="$2"
    local PORT_TO_LISTEN=$3
    local NETWORK==${4:-"$DOCKER_NET_DEV"}
    
    $DOCKER run -d --name $DOCKER_NAME --network $DOCKER_NET_DEV \
    -it --link=mariadb-server-develop \
    -v "$LOCAL_PATH":/app/www \
    -p $PORT_TO_LISTEN:80 \
    cht_webphp5
}

ct_docker_ServerApp_Oracle18() {
    local name=${1:-"oracle18"} # Name
    local senha=${2:-"oracle"} # Senha
    local ports=${3:-"1521:1521"} # Ports

    echo_and_run $DOCKER run -d --name $name -p $ports -e ORACLE_RANDOM_PASSWORD=yes -v oracle-volume:/opt/oracle/oradata gvenzl/oracle-xe:18.4.0-slim

    echo "--------
Reset database SYS and SYSTEM passwords:

docker exec <container name|id> resetPassword <your password>"
}

ct_docker_WebApp_ApachePHP5() {
    : ${1?' port_to_listen'}
    docker run -d --name apache-php5 -p $1:80 -v "$PWD":/web nimmis/alpine-apache-php5
}

ct_docker_WebApp_AlpineApachePHP7() {
    : ${1?' port_to_listen'}
    docker run -d --name apache-php7 -p $1:80 -v "$PWD":/app ulsmith/alpine-apache-php7
}

ct_docker_WebApp_DeezLoaderMX() {
    $DOCKER_X11_SHORT --name deezloader$RAND bocki/deezloaderrmx
}

ct_docker_WebApp_Wordpress() {
    echo -e "Você está montando a pasta $CGreen$PWD$Color_Off, se não conter os arquivos padrões do wordpress, será populado"
    : ${1?' docker_name'}
    
    __qualquerTeclaContinuar
    
    : ${2?' WORDPRESS_DB_HOST'}
    : ${3?' WORDPRESS_DB_USER'}
    : ${4?' WORDPRESS_DB_PASSWORD'}
    : ${5?' WORDPRESS_DB_NAME'}
    : ${6?' PORT'}
    
    echo_and_run $DOCKER run -d -it --name "$1" -p $6:80 \
    -e WORDPRESS_DB_HOST=$2 \
    -e WORDPRESS_DB_USER=$3 \
    -e WORDPRESS_DB_PASSWORD=$4 \
    -e WORDPRESS_DB_NAME=$5 "$7" \
    -v "$PWD":/var/www/html \
    'wordpress:5.4.2-php7.3-apache'
}

# https://docs.litespeedtech.com/cloud/docker/
# https://docs.litespeedtech.com/cloud/docker/openlitespeed/
# https://docs.litespeedtech.com/cloud/docker/litespeed/
ct_docker_OLS() {
    docker run -d --name openlitespeed -p 7080:7080 -p 80:80 -p 443:443 -it litespeedtech/openlitespeed:latest
    open https://hub.docker.com/r/litespeedtech/openlitespeed
}

# https://docs.litespeedtech.com/cloud/docker/ols+wordpress/
ct_docker_OLS_Download_Git_And_Run_docker_compose() {
    cd /projetos
    git clone https://github.com/c4tom/ols-docker-env
    cd ols-docker-env
    docker-compose up
}

### My Develop

#https://hub.docker.com/_/node
ct_docker_base_node() {
    local VERSION=${1:-"18"}
    echo_and_run $DOCKER run -d -it --name node-${VERSION} node:${VERSION}-alpine
}

# https://hub.docker.com/r/adoptopenjdk/openjdk12
ct_docker_base_openJDK12() {
    echo_and_run $DOCKER run -d -it --name openJDK12 adoptopenjdk/openjdk12
}

# Ubuntu 22.04
ct_docker_base_ubuntu_22() {
    echo_and_run $DOCKER run -d -it --name ubuntu_jammy_22_4 ubuntu:22.04
}

# Ubuntu 20.04
ct_docker_base_ubuntu_20() {
    echo_and_run $DOCKER run -d -it --name ubuntu_focal_20_4 ubuntu:20.04
}

ct_docker_base_ubuntu_18() {
    echo_and_run $DOCKER run -d -it --name ubuntu_bionic_18_04 ubuntu:18.04
}

#### Oracle Linux ####
ct_docker_base_oraclelinux_8_7() {
    echo_and_run $DOCKER run -d -it --name oracle_linux_8_7 oraclelinux:8.7
}


#### ALPINE #####
ct_docker_base_alpine_any() {
    local container_name=${1:-"alpine_latest"}
    local image_name=${2:-"alpine:latest"}
    echo_and_run $DOCKER run -d -it --name $container_name $image_name
}

# Alpine 3.12
ct_docker_base_alpine_3_12() {
    ct_docker_base_alpine_any alpine_3_12 alpine:3.12
}

#### CentOS #####
ct_docker_base_centOS() {
    echo_and_run $DOCKER run -d -it --name centos:latest
}

#### Debian #####
ct_docker_base_debian_any() {
    local container_name=${1:-"debian_latest"}
    local image_name=${2:-"debian:latest"}
    echo_and_run $DOCKER run -d -it --name $container_name $image_name
}

ct_docker_base_debian_11() {
    ct_docker_base_debian_any debian_bullseye debian:11-slim
}

ct_docker_base_debian_10() {
    ct_docker_base_debian_any debian_buster debian:10-slim
}

ct_docker_base_debian_8() {
    ct_docker_base_debian_any debian_jessie_8 debian:8-slim
}

#### Mint #####


#### Oracle Linux ####

ct_docker_base_oraclelinux_8slim() {
    local DOCKERNAME=oracle_8-slim
    local DOCKERIMG=oraclelinux
    local DOCKERTAG=8-slim
    echo_and_run $DOCKER run -d -it --name $DOCKERNAME $DOCKERIMG:$DOCKERTAG
    echo_and_run $DOCKER exec -ti $DOCKERNAME cat /etc/os-release
}

#### Others ####

ct_docker_traefik() {
    local admport=${2:-"18080:8080"}
    echo_and_run docker run -d -p $admport -p 80:80 \
    -v $PWD/traefik.yml:/etc/traefik/traefik.yml \
    -v /var/run/docker.sock:/var/run/docker.sock \
    traefik:v2.0
}



ct_docker_App_nextcloud_aio() {
    [[ -f $(type -P xdg-open) ]] && { xdg-open https://github.com/nextcloud/all-in-one; }
    
    echo_and_run docker run -d -it \
    --name nextcloud-aio-mastercontainer \
    --restart always \
    -p 80:80 \
    -p 8080:8080 \
    -p 8443:8443 \
    --volume nextcloud_aio_mastercontainer:/mnt/docker-aio-config \
    --volume /var/run/docker.sock:/var/run/docker.sock:ro \
    nextcloud/all-in-one:latest
}


ct_docker_XApp_Chrome() {

    echo "Build docker"
    echo_and_run docker build --pull --rm -f "../servidores/docker/dockerFiles/debian/debian11_chrome/Dockerfile" -t cahato_chrome:latest "../servidores/docker/dockerFiles/debian/debian11_chrome"



    docker run -d -it --net host --cpuset-cpus 0 \
    --memory 512mb \
    -v /tmp/.X11-unix:/tmp/.X11-unix \
    -e DISPLAY=unix$DISPLAY \
    -v $HOME/Downloads:/root/Downloads \
    --device /dev/snd \
    --security-opt seccomp:unconfined \
    --entrypoint /bin/sh \
    --name debian11_chrome:latest \
    alpine
}


ct_docker_camunda() {
    echo_and_run docker run --rm -it  \
    --name camundaLatest \
    -p 8000:8000/tcp \
    -p 8080:8080/tcp \
    -p 9404:9404/tcp \
    camunda/camunda-bpm-platform:run-latest
}

ct_docker_n8n() {
    docker run -it --rm \
    --name n8n \
    -p 5678:5678 \
    -v ~/.n8n:/home/node/.n8n \
    n8nio/n8n
}


# https://docs.n8n.io/hosting/installation/docker/#using-alternate-databases
ct_docker_n8n_viaComposer() {

    [[ -f /usr/bin/docker ]] || { echo "Please install docker, run: ct_docker_install_DockerCE"; return; }
    [[ -f $(type -P docker-compose) ]] || { echo "Please install docker-compose: run ct_docker_install_ComposeDownload"; return; }

    local n8n_path=$HOME/dockers/n8n
    local n8n_composer=$n8n_path/docker-compose.yml

    [[ -f $n8n_composer ]] && { echo "Already exist $n8n_composer"; return; }

    mkdir -p $n8n_path

    echo '
version: "3"

services:
  traefik:
    image: "traefik"
    restart: always
    command:
      - "--api=true"
      - "--api.insecure=true"
      - "--providers.docker=true"
      - "--providers.docker.exposedbydefault=false"
      - "--entrypoints.web.address=:80"
      - "--entrypoints.web.http.redirections.entryPoint.to=websecure"
      - "--entrypoints.web.http.redirections.entrypoint.scheme=https"
      - "--entrypoints.websecure.address=:443"
      - "--certificatesresolvers.mytlschallenge.acme.tlschallenge=true"
      - "--certificatesresolvers.mytlschallenge.acme.email=${SSL_EMAIL}"
      - "--certificatesresolvers.mytlschallenge.acme.storage=/letsencrypt/acme.json"
    ports:
      - "80:80"
      - "443:443"
    volumes:
      - ${DATA_FOLDER}/letsencrypt:/letsencrypt
      - /var/run/docker.sock:/var/run/docker.sock:ro

  n8n:
    image: n8nio/n8n
    restart: always
    ports:
      - "127.0.0.1:5678:5678"
    labels:
      - traefik.enable=true
      - traefik.http.routers.n8n.rule=Host(`${SUBDOMAIN}.${DOMAIN_NAME}`)
      - traefik.http.routers.n8n.tls=true
      - traefik.http.routers.n8n.entrypoints=web,websecure
      - traefik.http.routers.n8n.tls.certresolver=mytlschallenge
      - traefik.http.middlewares.n8n.headers.SSLRedirect=true
      - traefik.http.middlewares.n8n.headers.STSSeconds=315360000
      - traefik.http.middlewares.n8n.headers.browserXSSFilter=true
      - traefik.http.middlewares.n8n.headers.contentTypeNosniff=true
      - traefik.http.middlewares.n8n.headers.forceSTSHeader=true
      - traefik.http.middlewares.n8n.headers.SSLHost=${DOMAIN_NAME}
      - traefik.http.middlewares.n8n.headers.STSIncludeSubdomains=true
      - traefik.http.middlewares.n8n.headers.STSPreload=true
    environment:
      - N8N_BASIC_AUTH_ACTIVE=true
      - N8N_BASIC_AUTH_USER
      - N8N_BASIC_AUTH_PASSWORD
      - N8N_HOST=${SUBDOMAIN}.${DOMAIN_NAME}
      - N8N_PORT=5678
      - N8N_PROTOCOL=https
      - NODE_ENV=production
      - WEBHOOK_URL=https://${SUBDOMAIN}.${DOMAIN_NAME}/
      - GENERIC_TIMEZONE=${GENERIC_TIMEZONE}
    volumes:
      - ${DATA_FOLDER}/.n8n:/home/node/.n8n

' > $n8n_composer

echo '
# Folder where data should be saved
DATA_FOLDER='$n8n_path'

# The top level domain to serve from
DOMAIN_NAME=example.com

# The subdomain to serve from
SUBDOMAIN=n8n

# DOMAIN_NAME and SUBDOMAIN combined decide where n8n will be reachable from
# above example would result in: https://n8n.example.com

# The user name to use for authentication - IMPORTANT ALWAYS CHANGE!
N8N_BASIC_AUTH_USER=user

# The password to use for authentication - IMPORTANT ALWAYS CHANGE!
N8N_BASIC_AUTH_PASSWORD=password

# Optional timezone to set which gets used by Cron-Node by default
# If not set New York time will be used
GENERIC_TIMEZONE=America/Sao_Paulo

# The email address to use for the SSL certificate creation
SSL_EMAIL=user@example.com
' > $n8n_path/.env

    echo "#!/bin/sh\ndocker-compose up -d" > $n8n_path/start.sh
    echo "#!/bin/sh\ndocker-compose stop" > $n8n_path/stop.sh
    chmod +x $n8n_path/*.sh

}