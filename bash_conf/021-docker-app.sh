DOCKER_X11="/tmp/.X11-unix:/tmp/.X11-unix"
DOCKER_DISPLAY="DISPLAY=unix$DISPLAY"

DOCKER_X11_SHORT="docker run -ti --rm -v $DOCKER_X11 -e $DOCKER_DISPLAY --device /dev/dri --net=host"

ct_docker_AppVisualStudioCodePHP() {
	# Execute na pasta aonde quer o document_root
	local RAND=`ct_rand0_999`
	$DOCKER_X11_SHORT -v "$PWD":/var/www/html --name vscode$RAND insready/vscode-php
}

ct_docker_AppSublimeText3() {
	# Execute na pasta aonde quer o document_root
	local RAND=`ct_rand0_999`
	$DOCKER_X11_SHORT -v "$PWD":/home --name sublime$RAND jess/sublime-text-3
}

ct_docker_AppLXDEWine() {
	$DOCKER_X11_SHORT --name lxdewine$RAND x11docker/lxde-wine
}
ct_docker_AppXFCEWine() {
	$DOCKER_X11_SHORT --name lxdewine$RAND x11docker/xfce-wine-playonlinux
}

ct_docker_AppDBSchema() {
	$DOCKER_X11_SHORT --name dbschema$RAND dbschema:latest
}



ct_docker_AppApachePHP5() {
	docker run -d --name apache-php5 -v "$PWD":/web nimmis/alpine-apache-php5
}

ct_docker_AppCrossOver() {
	$DOCKER_X11_SHORT --name crossover$RAND crossover:latest
}