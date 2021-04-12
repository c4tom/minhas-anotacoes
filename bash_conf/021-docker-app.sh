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
	echo_and_run $DOCKER run -d -it --name node node:14-alpine
}

# https://hub.docker.com/r/adoptopenjdk/openjdk12
ct_docker_base_openJDK12() {
	echo_and_run $DOCKER run -d -it --name openJDK12 adoptopenjdk/openjdk12
}

# Ubuntu 20.04
ct_docker_base_ubuntu_20() {
	echo_and_run $DOCKER run -d -it --name ubuntu_focal_20_4 ubuntu:20_04
}

ct_docker_base_ubuntu_18() {
	echo_and_run $DOCKER run -d -it --name ubuntu_bionic_18_04 ubuntu:18.04
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

ct_docker_base_debian_10() {
	ct_docker_base_debian_any debian_buster debian:10-slim
}

ct_docker_base_debian_8() {
	ct_docker_base_debian_any debian_jessie_8 debian:8-slim
}

#### Mint #####

#### Others ####

ct_docker_traefik() {
	local admport=${2:-"18080:8080"}
	echo_and_run docker run -d -p $admport -p 80:80 \
		-v $PWD/traefik.yml:/etc/traefik/traefik.yml \
		-v /var/run/docker.sock:/var/run/docker.sock \
		traefik:v2.0
}
