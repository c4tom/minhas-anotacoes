nixName="`uname -n`/`uname -r`"
echoColor "Olá, como vai $BGreen$USER?$Color_Off Hora: $CCyan`date` :: $nixName"


sys_status() {

    RAM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
    LOAD=$(uptime | awk -F'[a-z]:' '{ print $2}')
    DISK=$(df -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
    CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')

    cat <<EOF
    System Status:
    $(echo "Load :")$(echo "$LOAD")
    $(echo "CPU  :") $(echo "$CPU")
    $(echo "RAM  :") $(echo "$RAM")
    $(echo "Disk :") $(echo "$DISK")
EOF

}
sys_status

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

	if [ "" == "$1" ] || [ "-?" == "$1" ] || [ "?" == "$1" ]; then
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