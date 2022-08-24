[[ `isWin` == "1" ]] || { return ; }

[[ -f /usr/sbin/tincd ]] || { return ; }

export TINC_PORT=655

#
# obs: pegar a chave.pub do servidor e copia-la no host/server do cliente
# e copiar a chave.pub do cliente host/cliente-nome para o servidor host/cliente-nome
# assim funcionara
#

tincSetupUPDOWN() {
    local ip=$1
    local TINC_ETC=$2
        echo "#!/bin/sh
ifconfig \$INTERFACE $ip netmask 255.255.255.0" | sudo tee --append $TINC_ETC/tinc-up > /dev/null

    echo "#!/bin/sh
ifconfig \$INTERFACE down" | sudo tee --append $TINC_ETC/tinc-down > /dev/null

    sudo chmod 755 $TINC_ETC/tinc-*
}

#Criar um servidor, configuração apenas para 1 rede
tincServerSetup() {
    local NOMEREDE=$1
    local SERVER_HOSTNAME=$2 # server
    local IP_DO_SERVIDOR_NA_REDE=$3 # 10.0.0.1

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts

    sudo mkdir -p $TINC_ETC

    echo "Name = $SERVER_HOSTNAME
AddressFamily = ipv4
Interface = tun0
TCPOnly = true" | sudo tee --append $TINC_ETC > /dev/null

    sudo mkdir -p $TINC_HOSTS

    echo "Address = IP_PUBLICO_OU_EXTERNO
Subnet = $IP_DO_SERVIDOR_NA_REDE/32" | sudo tee --append $TINC_HOSTS/$SERVER_HOSTNAME > /dev/null

    tincMakeKey $NOMEREDE

    tincSetupUPDOWN $IP_DO_SERVIDOR_NA_REDE $TINC_ETC

    _tincNetsBoot $NOMEREDE
}

_tincNetsBoot()
{
    echo "$1" | sudo tee --append /etc/tinc/nets.boot > /dev/null
}

tincMakeKey() {
    local nomeRede=$1
    sudo tincd -n $nomeRede -K4096
}

# Criar um host cliente, configuração apenas para 1 rede
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

    tincMakeConf "$NOMEREDE" $CLIENT_HOST $CONNECT_TO $NOMEREDE

    _tincNetsBoot "$NOMEREDE" 
}

tincMakeClientHosts() {
    local NOMEREDE=$1
    local CLIENT_HOST=$2 # cliente1
    local IP_SUBREDE=$3 # 10.0.0.2-254
    local CONNECT_TO=$4 # nome do servidor (server)

    local TINC_ETC=/etc/tinc/$NOMEREDE
    local TINC_HOSTS=$TINC_ETC/hosts

    echo "Name = $CLIENT_HOST
AddressFamily = ipv4
Interface = tun0
Subnet = $IP_SUBREDE
ConnectTo = $CONNECT_TO
Port = $TINC_PORT" | sudo tee --append $TINC_HOSTS/$CLIENT_HOST > /dev/null
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
" | sudo tee --append $TINC_ETC/tinc.conf > /dev/null
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
" | sudo tee --append $TINC_HOSTS/$CLIENT_HOST > /dev/null
}