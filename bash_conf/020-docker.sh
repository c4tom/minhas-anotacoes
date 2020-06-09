


[[ -f /usr/bin/docker ]] || { 
	ct_docker_install_DockerCE() {
		local UBUNTU_RELEASE=bionic
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

[[ -f /usr/bin/kitematic ]] || { 
	ct_docker_install_Kitematic() {
		local VERSION="0.17.7"
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
		local VERSION="1.25.0-rc2"
		sudo curl -L https://github.com/docker/compose/releases/download/$VERSION/docker-compose-`uname -s`-`uname -m` -o /usr/bin/docker-compose && sudo chmod +x /usr/bin/docker-compose && docker-compose --version

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
	$DOCKER build -t $CONTAINER_NAME .
}

# $1 nome da imagem docker
# docker run -ti --rm  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix firefox
# docker run -d --device /dev/snd --name pidgin -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY thshaw/pidgin
ct_docker_runAnyXApp() {
	local imagemNome=$1
	local cmd=$($DOCKER run -d --net host --name $1 -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:$HOME/.Xauthority --privileged=true $imagemNome $2 $3 $4)
	echo $cmd;
	$cmd
}


ct_docker_dashboard() {
	docker ps 
}


# $1 nome do container
# execute: docker ps -a
ct_docker_bash() {
	local CONTAINER_NAME=$1
	$DOCKER exec -ti $CONTAINER_NAME bash
}

ct_docker_exec() {
	local CONTAINER_NAME=$1
	local CMD="$2"
	$DOCKER exec -ti $CONTAINER_NAME $CMD
}

# sem TTY
ct_docker_exec_noTI() {
	local CONTAINER_NAME=$1
	local CMD="$2"
	$DOCKER exec $CONTAINER_NAME $CMD
}

# Conteudo para usar as melhores praticas ao criar Dockfile
ct_docker_bestPratice(){
	xdg-open https://docs.docker.com/develop/develop-images/dockerfile_best-practices
}


#https://docs.docker.com/config/pruning/#prune-everything
ct_docker_removeTudo() {
	echo "ATENÇÃO: Isso removerá tudo, desde imagens, containers e cache\nCTRL+c para abortar"
	read tmp
	docker system prune --all
}


ct_docker_intoDocker_adicionarRepoBrasilDebian() {
	echo "
	\`RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian jessie main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list\`
	"
}

ct_docker_intoDocker_aheckStatusWeb() {
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
	docker ps
	echoYellowBlack "Digite o CONTAINER_ID: "
	read dockerID

	docker update --restart=always $dockerID
}



## docker volume

# https://howchoo.com/g/zgrmzguwztv/how-to-remove-orphaned-volumes-in-docker
ct_docker_volume_deleteOrphan() {
	$DOCKER volume rm $(ct_dockerVolumeListOrphan)
}

ct_docker_volume_listOrphan() {
	$DOCKER volume ls -qf dangling=true
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
	#docker login -u $DOCKERHUB_LOGIN
	echo $NOME_REPO

}



## docker container
ct_docker_container_listAllStopped() {
	$DOCKER ps -a | grep Exited
}

ct_docker_container_removeAll() {
	$DOCKER container prune
}

## docker network
ct_docker_network_removeAll() {
	$DOCKER network prune
}





## docker network

ct_docker_network_createDevelop() {
	$DOCKER network create develop --driver bridge
}


