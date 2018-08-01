DOCKER=/usr/bin/docker
[[ -f $DOCKER ]] || { return ; }


# Lista a quantidade de memoria utilizada para cada container em execução
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