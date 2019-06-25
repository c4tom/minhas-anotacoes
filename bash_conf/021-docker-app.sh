DOCKER_X11="/tmp/.X11-unix:/tmp/.X11-unix"
DOCKER_DISPLAY="DISPLAY=unix$DISPLAY"

DOCKER_X11_SHORT="docker run -ti --rm -v $DOCKER_X11 -e $DOCKER_DISPLAY --device /dev/dri --net=host"

ct_docker_AppVisualStudioCodePHP() {
	# Execute na pasta aonde quer o document_root
	local RAND=`ct_rand0_999`
	$DOCKER_X11_SHORT -v "$PWD":/var/www/html --name vscode$RAND docker-vscode-php:latest
}

ct_docker_AppSublimeText3() {
	# Execute na pasta aonde quer o document_root
	local RAND=`ct_rand0_999`
	$DOCKER_X11_SHORT -v "$PWD":/home --name sublime$RAND jess/sublime-text-3
}