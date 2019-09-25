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


ct_help() {

	if [ "-?" == "$1" ]; then
		echo 
		echo -e $HELPTXT
		echo 

		kill -INT $$
	fi
}