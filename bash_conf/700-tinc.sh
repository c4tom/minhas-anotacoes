[[ -f /usr/sbin/tincd ]] || { return ; }

export TINC_PORT=656


tincSetupUPDOWN() {
    local ip=$1
    local TINC_ETC=$2
        sudo echo "#!/bin/sh
ifconfig \$INTERFACE $ip netmask 255.255.255.0" > $TINC_ETC/tinc-up

    sudo echo "#!/bin/sh
ifconfig \$INTERFACE down" > $TINC_ETC/tinc-down

    sudo chmod 755  > $TINC_ETC/tinc-*
}

#Rodar no servidor, configuração apenas para 1 rede
tincServerSetup() {
    local NOMEREDE=$1
    local SERVER_HOST=$2 # server
    local IP_SUBREDE="10.0.0.1"

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts

    sudo mkdir -p $TINC_ETC

    echo "Name = $SERVER_HOST
AddressFamily = ipv4
Interface = tun0
TCPOnly = true" > $TINC_ETC

    sudo mkdir -p $TINC_HOSTS

    sudo echo "Address = IP_PUBLICO_OU_EXTERNO
Subnet = $IP_SUBREDE/32" > $TINC_HOSTS/$SERVEHOST

    tincMakeKey $NOMEREDE

    tincSetupUPDOWN $IP_SUBREDE $TINC_ETC

    sudo echo "$NOMEREDE" > /etc/tinc/nets.boot
}

tincMakeKey() {
    local nomeRede=$1
    sudo tincd -n $nomeRede -K4096
}

# Rodar no cliente, configuração apenas para 1 rede
tincClientSetup() {
    local NOMEREDE=$1
    local CLIENT_HOST=$2 # cliente1
    local IP_SUBREDE=$3 # 10.0.0.2-254
    local CONNECT_TO=$4 # nome do servidor (server)

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts

    sudo mkdir -p $TINC_ETC $TINC_HOSTS

    tincMakeClientHosts $NOMEREDE $CLIENT_HOST $IP_SUBREDE $CONNECT_TO

    tincSetupUPDOWN $IP_SUBREDE $TINC_ETC

    sudo echo "$NOMEREDE" > /etc/tinc/nets.boot
}
tincMakeClientHosts() {
    local NOMEREDE=$1
    local CLIENT_HOST=$2 # cliente1
    local IP_SUBREDE=$3 # 10.0.0.2-254
    local CONNECT_TO=$4 # nome do servidor (server)

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts

    sudo echo "Name = $CLIENT_HOST
AddressFamily = ipv4
Interface = tun0
Subnet = $IP_SUBREDE
ConnectTo = $CONNECT_TO
Port = $TINC_PORT" > $TINC_HOSTS/$CLIENT_HOST
}


tincMakeConf() {
    local NOMEREDE=$1
    local CLIENT_HOST=$2 # server
    local CONNECT_TO=$3 # nome do servidor (server)
    local IFACE=$4

    local TINC_ETC=/etc/tinc/$NOMEREDE
    echo "Name = $CLIENT_HOST
Device = /dev/net/tun
AddressFamily = ipv4
Interface = $IFACE
TCPOnly = yes
ConnectTo=$CONNECT_TO
" > $TINC_ETC/tinc.conf
}

tincServerHostClient() {
    local NOMEREDE=$1
    local CLIENT_HOST=$2 # server
    local IP_SUBREDE=$3 # 10.0.0.2-254
    local ADDRESS_URL=$4 # clarosoffice.no-ip.biz

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts


    echo "Address = $ADDRESS_URL
AddressFamily = ipv4
Subnet = $IP_SUBREDE
TCPOnly = yes
Port = $TINC_PORT
" > $TINC_HOSTS/$CLIENT_HOST
}