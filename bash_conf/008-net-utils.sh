__macAddrGen() {
	hexdump -n 6 -ve '1/1 "%.2x "' /dev/random | awk -v a="2,6,a,e" -v r="$RANDOM" 'BEGIN{srand(r);}NR==1{split(a,b,",");r=int(rand()*4+1);printf "%s%s:%s:%s:%s:%s:%s\n",substr($1,0,1),b[r],$2,$3,$4,$5,$6}'
}


[[ ! -f /bin/netstat ]] || { 
    ct_net_stat() {
        local CMD="netstat -tulpn | grep tcp"
        echoColor $BGreen"$CMD"
        eval $CMD
    }
}

# nc into netcat package	
[[ ! -f /bin/nc ]] || { 
	ct_net_waitServiceConnectPort() {

	HELPTXT="

${FUNCNAME[0]} <host> <port>"
	ct_help $1

	: ${1?' host'}
	: ${2?' port'}

		local HOST=$1
		local PORT=$2

		while ! nc -w 1 $HOST $PORT 2>/dev/null
		do
			echo -n .
			sleep 1
		done
		echo 'OK'
	}
}

# https://stackoverflow.com/questions/9609130/efficiently-test-if-a-port-is-open-on-linux-without-nmap-or-netcat#9609247
# retorna closed|open
ct_net_checkLocalhostPortIsListen() {
	local PORT=$1
	true &>/dev/null < /dev/tcp/127.0.0.1/$PORT && echo open || echo closed
}


# https://askubuntu.com/questions/1320276/how-to-easily-get-all-https-addresses-that-an-application-connects-externally/1361293#1361293
ct_net_print_who_connected_ports80_443() {
	watch -n1 lsof -i TCP:80,443 
}

ct_monitor_my_router() {
	local ROUTER_IP=${1:-"192.168.1.254"};
	local ROUTER_PORT=${2:-"443"};
	# 0 => is online
	# 1 => is offline
	
	while(true)
	do
		isOFFLINE=$(nc -z $ROUTER_IP $ROUTER_PORT; echo $?)
		echo "$(date) => $isOFFLINE" | tee -a ~/modem_isonline.log
		sleep 30
	done
}