[[ -f /usr/bin/docker ]] || { return ; }
DOCKER=/usr/bin/docker

# Lista a quantidade de memoria utilizada para cada container em execu√ß√£o
ct_dockerTotalMemory(){
	for line in `$DOCKER ps | awk '{print $1}' | grep -v CONTAINER`; do $DOCKER ps | grep $line | awk '{printf $NF" "}' && echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 ))MB ; done
}

# $1 - nome da tag
ct_dockerBuild(){ 
	#docker build -t $1 - < Dockerfile
	$DOCKER build -t $1 .
}

# $1 nome da imagem docker
# docker run -ti --rm  -e DISPLAY=$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix firefox
# docker run -d --device /dev/snd --name pidgin -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=unix$DISPLAY thshaw/pidgin
ct_dockerX() {
	local imagemNome=$1
	local cmd=$($DOCKER run -d --net host --name $1 -e DISPLAY=unix$DISPLAY -v /tmp/.X11-unix:/tmp/.X11-unix -v $HOME/.Xauthority:$HOME/.Xauthority --privileged=true $imagemNome $2 $3 $4)
	echo $cmd;
	$cmd
}

ct_dockerKitematicLauncher() {
	$DOCKER run -d --net host --name kitematic -v /tmp/.X11-unix:/tmp/.X11-unix -e DISPLAY=$DISPLAY -v $HOME/.Xauthority:/root/.Xauthority 
 -v /var/run/docker.sock:/var/run/docker.sock --privileged=true jonadev95/kitematic-docker
}

# https://docs.docker.com/compose/install/#upgrading
ct_dockerComposeDownloadInstall() {
	cd /tmp/
	sudo curl -L https://github.com/docker/compose/releases/download/1.19.0/docker-compose-`uname -s`-`uname -m` -o /usr/local/bin/docker-compose && sudo chmod +x /usr/local/bin/docker-compose && docker-compose --version

}

# $1 nome do container
# execute: docker ps -a
ct_dockerBash() {
	$DOCKER exec -ti $1 bash
}

# Conteudo para usar as melhores praticas ao criar Dockfile
ct_dockerBestPratice(){
	xdg-open https://docs.docker.com/develop/develop-images/dockerfile_best-practices
}


#https://docs.docker.com/config/pruning/#prune-everything
ct_dockerRemoveTudo() {
	echo "ATEN«√O: Isso remover· tudo, desde imagens, containers e cache"
	docker system prune --all
}

#$ docker login -u {docker-hub-username}
#<enter user name and password for Docker Hub Repository>
#$ docker tag first-image {docker-hub-username}/{default-repo-folder-name}:first-image
#$ docker push {docker-hub-username}/{default-repo-folder-name}:first-image
#
# ou configure $HOME/.docker/config.json em 
# https://docs.docker.com/engine/reference/commandline/login/#default-behavior
ct_dockerPush() {
	[ ! -z $DOCKERHUB_LOGIN ] || { echo "Defina DOCKERHUB_LOGIN, ou adicione em .bashrc ou .profile"; return; }
	
	local NOME_TAG=$1
	local NOME_REPO=$(dirname `pwd`/a)
	echo "Senha para logar no hub.docker.com"
	#docker login -u $DOCKERHUB_LOGIN
	echo $NOME_REPO

}

ct_dockerInfoAdicionarRepoBrasilDebian() {
	echo "
	\`RUN cat /etc/apt/sources.list | \
    sed '1s#.*#deb http://ftp.br.debian.org/debian jessie main contrib non-free#' > /etc/apt/sources.list.new \
    && cat /etc/apt/sources.list.new > /etc/apt/sources.list\`
	"
}

ct_dockerCheckStatusWeb() {
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

