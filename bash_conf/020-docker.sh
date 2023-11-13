# TODO https://docs.docker.com/storage/storagedriver/btrfs-driver/


[[ -f /usr/bin/docker ]] || { 
	[[ $HASAPT = false ]] && { return; }
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
	return ; 

}

DOCKER=/usr/bin/docker
DOCKER_VERSION=$(docker version --format '{{.Server.Version}}')
DOCKER_BUILDKIT=1

[[ -f /usr/bin/kitematic ]] || { 
	ct_docker_install_Kitematic() {
		local VERSION="0.17.13"
		curl -L -o /tmp/kitematic.zip https://github.com/docker/kitematic/releases/download/v$VERSION/Kitematic-$VERSION-Ubuntu.zip
		cd /tmp
		unzip kitematic.zip 
		sudo dpkg -i "Kitematic-"$VERSION"_amd64.deb"
	}
}

[[ -f /usr/bin/docker-compose ]] || { 
	# https://docs.docker.com/compose/install/#upgrading
	ct_docker_install_ComposeDownload() {
		cd /tmp/
		local VERSION="v2.5.1"
		# https://github.com/docker/compose/releases/download/v2.5.1/docker-compose-linux-x86_64
		local linkDownload=https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s | tr "[:upper:]" "[:lower:]"`-`uname -m`
		sudo curl -L $linkDownload -o /usr/bin/docker-compose && sudo chmod +x /usr/bin/docker-compose && docker-compose --version

	}
}



# Lista a quantidade de memoria utilizada para cada container em execu??o
ct_docker_totalMemory(){
	for line in `$DOCKER ps | awk '{print $1}' | grep -v CONTAINER`; do $DOCKER ps | grep $line | awk '{printf $NF" "}' && echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 ))MB ; done
}

# $1 - nome da tag/container
ct_docker_buildImage(){
	local CONTAINER_NAME=$1
	#docker build -t $1 - < Dockerfile
	echo_and_run $DOCKER build -t $CONTAINER_NAME .
}

# $1 nome da imagem docker
# docker run -ti --rm  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix firefox
# docker run -d --device /dev/snd --name pidgin -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY thshaw/pidgin
ct_docker_runAnyXApp() {
	local imagemNome=$1
	local cmd=$($DOCKER run -d --net host --name $1 -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:$HOME/.Xauthority --privileged=true $imagemNome $2 $3 $4)
	echo $cmd;
	echo_and_run $cmd
}


ct_docker_dashboard() {
	echo_and_run $DOCKER ps 
	echo_and_run $DOCKER system df -v
}

## docker run -it --entrypoint /bin/bash [docker_image]
# $1 nome do container
# execute: docker ps -a
ct_docker_bash() {
	local CONTAINER_NAME=$1
	echo_and_run $DOCKER exec -ti $CONTAINER_NAME /bin/sh -c "[ -e /bin/bash ] && /bin/bash || /bin/sh"
}

ct_docker_exec() {
	local CONTAINER_NAME=$1
	local CMD="$2"
	echo_and_run $DOCKER exec -ti $CONTAINER_NAME $CMD
}

# sem TTY
ct_docker_exec_noTI() {
	local CONTAINER_NAME=$1
	local CMD="$2"
	echo_and_run $DOCKER exec $CONTAINER_NAME $CMD
}

# Conteudo para usar as melhores praticas ao criar Dockfile
ct_docker_bestPratice(){
	xdg-open https://docs.docker.com/develop/develop-images/dockerfile_best-practices
}


#https://docs.docker.com/config/pruning/#prune-everything
ct_docker_removeTudo() {
	echo_and_run $DOCKER system df
	echoColor $BRed"ATENÇÃO:$CRed Isso removerá tudo, desde imagens, containers e cache e volumes locais
CTRL+c para abortar
"
	read tmp
	echo_and_run $DOCKER system prune --all
	echo_and_run $DOCKER volume prune
}


ct_docker_addInDockerFile_adicionarRepoBrasilDebian() {
	echo "
	\`RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian jessie main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list\`
	"
}

ct_docker_addInDockerFile_aheckStatusWeb() {
	local URL="$1"
	echo "  Wait until redmine be ready (wget required)"
	wget -w 5 --retry-connrefused --tries=60  $URL 2> /dev/null
	if [ $? -eq 0 ]
	then
    	echo ""
    	echo " You can now use your browser to accesss: $URL"
   else
    	echo ""
    	echo " ERROR: Timeout waiting for readmine"
   fi

}


ct_docker_setAutoStart() {
	$DOCKER ps
	echoYellowBlack "Digite o CONTAINER_ID: "
	read dockerID

	echo_and_run $DOCKER update --restart=always $dockerID
}



## docker volume

# https://howchoo.com/g/zgrmzguwztv/how-to-remove-orphaned-volumes-in-docker
ct_docker_volume_deleteOrphan() {
	local lsImgs=$(CT_VERBOSE=false ct_docker_volume_listOrphan)

	if [ -n "$lsImgs" ]
	then
		echo_and_run $DOCKER volume rm $lsImgs
	else
		echo "Nothing to remove"
	fi
}

ct_docker_volume_listOrphan() {
	echo_and_run $DOCKER volume ls -qf dangling=true
}


## docker image

# PULL Docker Image
#$ docker login -u {docker-hub-username}
#<enter user name and password for Docker Hub Repository>
#$ docker tag first-image {docker-hub-username}/{default-repo-folder-name}:first-image
#$ docker push {docker-hub-username}/{default-repo-folder-name}:first-image
#
# ou configure $HOME/.docker/config.json em 
# https://docs.docker.com/engine/reference/commandline/login/#default-behavior
ct_docker_push() {
	[ ! -z $DOCKERHUB_LOGIN ] || { echo "Defina DOCKERHUB_LOGIN, ou adicione em .bashrc ou .profile"; return; }
	
	local NOME_TAG=$1
	local NOME_REPO=$(dirname `pwd`/a)
	echo "Senha para logar no hub.docker.com"
	$DOCKER login -u $DOCKERHUB_LOGIN
	echo $NOME_REPO

}

# run this in image with problem to up
ct_docker_image_bash_entrypoint() {
		HELPTXT="
${FUNCNAME[0]} <image_name>"
	ct_help $1

	: ${1?' image_name'}

	local IMAGE_NAME=$1
	echo_and_run $DOCKER run -it --entrypoint /bin/bash $IMAGE_NAME
}



## docker container
ct_docker_container_listAllStopped() {
	$DOCKER ps -a | grep Exited
}

ct_docker_container_removeAll() {
	ct_docker_container_stopAll
	echo_and_run $DOCKER container prune
}

ct_docker_container_stopAll() {
	for i in $($DOCKER container ls -q)
	do
		$DOCKER container stop $i
	done
}

ct_docker_container_rm() {
	: ${1?' container_ID'}
	echo_and_run $DOCKER container stop $1
	echo_and_run $DOCKER container rm $1
}

## docker network
ct_docker_network_removeAll() {
	echo_and_run $DOCKER network prune
}

ct_docker_network_createDevelop(){
	if [[ ! -n $($DOCKER network ls | grep develop) ]];
	then
		echo_and_run $DOCKER network create develop --driver bridge
	fi
}

ct_docker_container_getIPAddress() {
	docker ps

	echo "Wich docker CONTAINER ID?"
	read docker_ID
	docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' $docker_ID
}


ct_docker_network_createMyNetworkBridge(){
	local subnet=${1:-"192.168.1.0/24"};
	local gateway=${1:-"192.168.1.254"};
	local netName=${1:-"minharedeWIFI"};
	echo_and_run $DOCKER network create -d bridge --subnet $subnet --gateway $gateway $netName
}


## Logs

ct_docker_logs() {
	docker ps
	echo ""
	echo "Escolha um CONTAINER ID: "

	read cID

	docker logs $cID --tail 100 -f
}



## Para Utilizar dentro dos DOCKER
# https://askubuntu.com/questions/541055/installing-packages-without-docs

ct_docker_addInDockerFile_apt_ignorarInstalarDocs() {
	echo "
path-exclude /usr/share/doc/*
# we need to keep copyright files for legal reasons
path-include /usr/share/doc/*/copyright
path-exclude /usr/share/man/*
path-exclude /usr/share/groff/*
path-exclude /usr/share/info/*
# lintian stuff is small, but really unnecessary
path-exclude /usr/share/lintian/*
path-exclude /usr/share/linda/*	
" > /etc/dpkg/dpkg.cfg.d/01_nodoc
}

ct_docker_addInDockerFile_apt_reduzir_footprint() {
	echo "
Acquire::GzipIndexes \"true\";
Acquire::CompressionTypes::Order:: \"gz\";	
" > /etc/apt/apt.conf.d/02compress-indexes
}




### UTILS

# https://docs.docker.com/storage/storagedriver/btrfs-driver/
ct_docker_storage_fs_overlay_to_brtfs() {
	 sudo cat /proc/filesystems | grep btrfs

	 sudo service docker stop

	 sudo cp -au /var/lib/docker /var/lib/docker.bk
	 sudo rm -rf /var/lib/docker/*
	 

	 # TODO
}



ct_dockerAndUFW_install() {
	# https://stackoverflow.com/questions/30383845/what-is-the-best-practice-of-docker-ufw-under-ubuntu/51741599#comment91451547_51741599
	# https://github.com/chaifeng/ufw-docker

	cd /tmp; git clone https://github.com/chaifeng/ufw-docker
	cd ufw-docker
	sudo cp ufw-docker /usr/sbin/ufw-docker
	sudo ufw-docker install

	sudo ufw-docker check
}



#!/bin/bash

# Função para definir as cores ANSI
ct_docker_tree_set_colors() {
    COLOR_CONTAINER_ID="\e[1;33m"  # Amarelo
    COLOR_IMAGE="\e[1;36m"         # Ciano
    COLOR_VOLUMES="\e[1;35m"       # Magenta
    COLOR_NETWORK="\e[1;32m"       # Verde
    COLOR_STATUS="\e[1;34m"        # Azul
    COLOR_RESOURCE="\e[1;31m"      # Vermelho
    COLOR_RESET="\e[0m"             # Resetar cor
}

# Função para obter informações detalhadas sobre volumes
ct_docker_tree_get_volume_info() {
    container_id=$1
    volumes=$(docker inspect --format="{{range .Mounts}}{{.Source}}:{{.Destination}},{{end}}" $container_id)
    
    if [ -n "$volumes" ]; then
        echo -e "    ${COLOR_VOLUMES}Volumes:${COLOR_RESET}"
        echo "$volumes" | awk -F',' 'NF>1 {for (i=1; i<NF; i++) print "      - " $i} NF==1 {print "      - " $1}'
    fi
}

# Função para obter informações detalhadas sobre redes
ct_docker_tree_get_network_info() {
    container_id=$1
    networks=$(docker inspect --format="{{range .NetworkSettings.Networks}}{{.NetworkID}}:{{.IPAddress}},{{end}}" $container_id)
    
    if [ -n "$networks" ]; then
        echo -e "    ${COLOR_NETWORK}Network:${COLOR_RESET}"
        echo "$networks" | awk -F',' 'NF>1 {for (i=1; i<NF; i++) print "      - " $i} NF==1 {print "      - " $1}'
    fi
}

# Função para obter informações detalhadas sobre recursos (CPU e memória)
ct_docker_tree_get_resource_info() {
    container_id=$1
    cpu=$(docker inspect --format="{{.Config.Env}}" $container_id | grep CPU_SHARES | cut -d '=' -f2)
    memory_limit=$(docker inspect --format="{{.HostConfig.Memory}}" $container_id)
    
    echo -e "    ${COLOR_RESOURCE}Recursos:${COLOR_RESET}"
    echo "      - CPU Shares: $cpu"
    echo "      - Memória Limite: $memory_limit"
}

# Função para obter informações sobre os containers
ct_docker_tree_get_container_info() {
    container_id=$1
    container_name=$(docker inspect --format="{{.Name}}" $container_id | sed 's/\///')  # Remover a barra inicial
    image=$(docker inspect --format="{{.Config.Image}}" $container_id)
    hostname=$(docker inspect --format="{{.Config.Hostname}}" $container_id)
    command=$(docker inspect --format="{{.Config.Cmd}}" $container_id)
    status=$(docker inspect --format="{{.State.Status}}" $container_id)
    started_at=$(docker inspect --format="{{.State.StartedAt}}" $container_id)

    echo -e "${COLOR_CONTAINER_ID}Container ID:${COLOR_RESET} $container_id"
    echo -e "${COLOR_CONTAINER_ID}  Nome do Container:${COLOR_RESET} $container_name"
    echo -e "${COLOR_IMAGE}  Image:${COLOR_RESET} $image"
    echo -e "${COLOR_STATUS}  Status:${COLOR_RESET} $status"
    echo -e "${COLOR_CONTAINER_ID}  Hostname:${COLOR_RESET} $hostname"
    echo -e "${COLOR_CONTAINER_ID}  Comando:${COLOR_RESET} $command"
    echo "      - Iniciado em: $started_at"

    ct_docker_tree_get_volume_info $container_id
    ct_docker_tree_get_network_info $container_id
    ct_docker_tree_get_resource_info $container_id
}

# Função para exibir a árvore de containers
ct_docker_tree() {
	ct_docker_tree_set_colors
    filter=$1
    containers=""

    case $filter in
        ativo)
            containers=$(docker ps -q)
            ;;
        inativo)
            containers=$(docker ps -q --filter "status=exited")
            ;;
        todos | *)
            containers=$(docker ps -aq)
            ;;
    esac

    if [ -z "$containers" ]; then
        echo "Nenhum container encontrado."
        return
    fi

    for container_id in $containers; do
        ct_docker_tree_get_container_info $container_id
    done
}


