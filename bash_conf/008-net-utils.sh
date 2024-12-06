# Utilitários de rede para Linux
#
# Este arquivo contém funções úteis para monitoramento e manipulação
# de conexões de rede, portas e endereços MAC

# Gera um endereço MAC aleatório válido
#
# Esta função usa /dev/random para gerar um endereço MAC
# que segue as convenções padrão de endereçamento
#
# Uso: __macAddrGen
#
# Retorna:
#   String contendo um endereço MAC válido no formato XX:XX:XX:XX:XX:XX
__macAddrGen() {
    hexdump -n 6 -ve '1/1 "%.2x "' /dev/random | awk -v a="2,6,a,e" -v r="$RANDOM" 'BEGIN{srand(r);}NR==1{split(a,b,",");r=int(rand()*4+1);printf "%s%s:%s:%s:%s:%s:%s\n",substr($1,0,1),b[r],$2,$3,$4,$5,$6}'
}

[[ ! -f /bin/netstat ]] || { 
    # Lista todas as conexões TCP ativas
    #
    # Mostra todas as conexões TCP ativas usando netstat,
    # filtrando apenas as conexões TCP
    #
    # Uso: ct_net_stat
    #
    # Retorna:
    #   Lista de conexões TCP ativas no formato do netstat
    ct_net_stat() {
        local CMD="netstat -tulpn | grep tcp"
        echoColor $BGreen"$CMD"
        eval $CMD
    }
}

# nc into netcat package    
[[ ! -f /bin/nc ]] || { 
    # Aguarda até que um serviço esteja disponível em uma porta
    #
    # Esta função tenta conectar-se repetidamente a uma porta
    # específica em um host até que o serviço esteja disponível
    #
    # Uso: ct_net_waitServiceConnectPort <host> <port>
    #
    # Parâmetros:
    #   host - O host a ser verificado
    #   port - A porta a ser verificada
    #
    # Retorna:
    #   Imprime 'OK' quando o serviço estiver disponível
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

# Verifica se uma porta local está em modo de escuta
#
# Testa se uma porta específica está aberta no localhost
# usando o dispositivo /dev/tcp
#
# Uso: ct_net_checkLocalhostPortIsListen <porta>
#
# Parâmetros:
#   porta - Número da porta a ser verificada
#
# Retorna:
#   'open' se a porta estiver aberta
#   'closed' se a porta estiver fechada
ct_net_checkLocalhostPortIsListen() {
    local PORT=$1
    true &>/dev/null < /dev/tcp/127.0.0.1/$PORT && echo open || echo closed
}

# Monitora conexões HTTP/HTTPS em tempo real
#
# Mostra todas as conexões TCP nas portas 80 e 443
# atualizando a cada segundo
#
# Uso: ct_net_print_who_connected_ports80_443
#
# Retorna:
#   Exibe continuamente as conexões HTTP/HTTPS ativas
ct_net_print_who_connected_ports80_443() {
    watch -n1 lsof -i TCP:80,443 
}

# Monitora o roteador usando ping
#
# Faz ping contínuo para o gateway padrão para
# monitorar sua disponibilidade
#
# Uso: ct_monitor_my_router
#
# Retorna:
#   Exibe resultados do ping continuamente
ct_monitor_my_router() {
    local ROUTER_IP=${1:-"192.168.1.254"};
    local ROUTER_PORT=${2:-"443"};
    # 0 => is online
    # 1 => is offline
    
    while true; do
        isOFFLINE=$(nc -z $ROUTER_IP $ROUTER_PORT; echo $?)
        echo "$(date) => $isOFFLINE" | tee -a ~/modem_isonline.log
        sleep 30
    done
}

# Obtém o IP público da máquina
#
# Usa serviços externos para determinar o endereço IP
# público da máquina atual
#
# Uso: ct_my_ip_internet
#
# Retorna:
#   Endereço IP público
ct_my_ip_internet() {
    IP=$(curl -s https://whatismyip.com.br/ | grep -A 1 "IP<" | grep "left" | sed -e 's/<[^>]*>//g')
    echo $IP
}

# Lista todas as portas em modo de escuta
#
# Mostra todas as portas TCP e UDP que estão
# em modo de escuta no sistema
#
# Uso: ct_net_list_all_listen_ports
#
# Retorna:
#   Lista de todas as portas em modo de escuta
ct_net_list_all_listen_ports() {
    echo_and_run sudo lsof -i -P -n | grep LISTEN
    echo_and_run sudo ss -tulpn | grep LISTEN
}
