nixName="`uname -n`/`uname -r`"
echoColor "Olá, como vai $BGreen$USER?$Color_Off Hora: $CCyan`date` :: $nixName"


sys_status() {

    if `isexec "/usr/bin/lsb_release"`;
        then
            LINUX="$(lsb_release -sd) - $(lsb_release -sc)"
            echo "    System Status: $LINUX";
    fi
    
    CPU=$(grep 'cpu ' /proc/stat | awk '{usage=($2+$4)*100/($2+$4+$5)} END {print usage "%"}')
    echo "    $(echo "CPU    :") $(echo ${CPU})"

    if `isexec "/usr/bin/free"`;
        then
            RAM=$(free -m | awk 'NR==2{printf "%s/%sMB (%.2f%%)\n", $3,$2,$3*100/$2 }')
            echo "    $(echo "RAM    :") $(echo ${RAM})"
    fi

    if `isexec "/usr/sbin/ip"`;
        then
            MAIN_IP=$(ip route get 8.8.8.8 | head -1 | awk '{print $7}')
            echo "    $(echo "IP     :") $(echo ${MAIN_IP})"
    fi

    if `isexec "/usr/bin/uptime"`;
        then
            LOAD=$(uptime | awk -F'[a-z]:' '{ print $2}')
            echo "    $(echo "Load   :") $(echo ${LOAD})"
            UPTIME=$(uptime -p)
            echo "    $(echo "UPTIME :") $(echo ${UPTIME})"
    fi
  
    DISK=$(df -l -h | awk '$NF=="/"{printf "%d/%dGB (%s)\n", $3,$2,$5}')
    echo "    $(echo "Disk   :") $(echo ${DISK})"


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