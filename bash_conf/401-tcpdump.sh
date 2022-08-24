[[ `isWin` == "1" ]] || { return ; }

[[ -f /usr/sbin/tcpdump ]] || { return ; }


ct_tcpdump_sniff_dns() {
    sudo tcpdump -vv udp port 53
}