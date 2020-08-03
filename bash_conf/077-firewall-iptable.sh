
[[ -f /usr/sbin/iptables ]] || { return ; }
# Somente root
# [[ $(id -u) -eq 0 ]] || { return ; }

IPTABLES="sudo /usr/sbin/iptables"

__fwChainsPolicies(){
    # Set Default Chain Policies
    $IPTABLES -P INPUT ACCEPT
    $IPTABLES -F INPUT
    $IPTABLES -P OUTPUT ACCEPT
    $IPTABLES -F OUTPUT
    $IPTABLES -P FORWARD DROP
    $IPTABLES -F FORWARD
}

ct_fwStop(){
    $IPTABLES -F
    $IPTABLES -X
    $IPTABLES -P INPUT ACCEPT
    $IPTABLES -P FORWARD DROP
    $IPTABLES -P OUTPUT ACCEPT
}

#https://serverfault.com/questions/401416/iptables-clear-all-prerouting-rules-with-a-specific-destination-address
ct_fwStopNat() {
    for i in $($IPTABLES -t nat --line-numbers -L | grep ^[0-9] | awk '{ print $1 }' | tac )
    do 
        $IPTABLES -t nat -D PREROUTING $i; 
    done
    ct_fwListarNat
}

ct_fwStart() {
    __fwChainsPolicies
}

ct_fwListar() {
    $IPTABLES -L
}

# https://stackoverflow.com/questions/41479879/how-to-check-prerouting-list-from-iptable-in-linux
ct_fwListarNat() {
    $IPTABLES -n -t nat --line-numbers -L
}

# https://askubuntu.com/questions/736413/docker-transparent-squid-proxy
ct_fwTransparentProxySquidSet() {
    $IPTABLES -t nat -A PREROUTING -p tcp --dport 80 -j REDIRECT --to 3128 -w
}
ct_fwTransparentProxySquidUnset() {
    $IPTABLES -t nat -D PREROUTING -p tcp --dport 80 -j REDIRECT --to 3128 -w
}


ct_fwBloquearTodosRequestDaInterface()
{
    local IFACE=$1
    local REDE=$2
    echo "Bloqueando todas requisições vinda na interface: $IFACE/$REDE"
    $IPTABLES -A INPUT -i $IFACE -p tcp --syn -s $REDE/24 -j REJECT
}
