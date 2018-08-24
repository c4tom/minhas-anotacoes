
[[ ! -f /bin/netstat ]] || { 
    ct_netStat() {
        local CMD="netstat -tulpn | grep tcp"
        echoColor $BGreen"$CMD"
        eval $CMD
    }
}

[[ ! -f /bin/nc ]] || { 
	ct_netWaitServiceConnectPort() {
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
ct_netCheckPortIsListen() {
	local PORT=$1
	true &>/dev/null </dev/tcp/127.0.0.1/$PORT && echo open || echo closed
}

