nixName="`uname -n`/`uname -r`"
echoColor "Olá, como vai $BGreen$USER?$Color_Off Hora: $CCyan`date` :: $nixName"

function child() {
    local parent_pid="$1"
    local other="$2"
    ...
    if [[ $failed ]]; then
        kill -QUIT "$parent_pid"
    fi
}

# Adicione isso, para cada funcao, quando por o primeiro argumento -? ou ?, imprime a ajuda
ct_help() {

	if [ "-?" == "$1" ] || [ "?" == "$1" ]; then
		echo 
		echo -e $HELPTXT
		echo 

		kill -INT $$
	fi
}

# Imprime o comando e execute-o
echo_and_run() {
    if [ $CT_VERBOSE == "true" ]; then 
        echoColor "$BYellow""command>$IPurple $*" ; "$@" ; 
    else 
        "$@" ;
    fi
}