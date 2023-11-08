ct_env_file_load() {
    if [ -f .env ]
    then
        export $(cat .env | xargs)
        echo "Variaveis exportadas"
    fi
}

cloudflare_basic_header() {
    echo '-H "X-Auth-Email: '$CLOUDFLARE_ID'" -H "X-Auth-Key: '$CLOUDFLARE_KEY'" -H "Content-Type: application/json"'
}

cloudflare_get_zones() {

    [[ -z "$CLOUDFLARE_ENDPOINT_ROOT" ]] && { echo "Favor executar ct_env_file_load aonde contem o .env"; return; }


    local ENDPOINT=$CLOUDFLARE_ENDPOINT_ROOT/zones
    local cmd="curl -X GET $ENDPOINT `cloudflare_basic_header`"
    eval "$cmd | python -mjson.tool"
     
}

cloudflare_get_dns_records() {

    [[ -z "$CLOUDFLARE_ENDPOINT_ROOT" ]] && { echo "Favor executar ct_env_file_load aonde contem o .env"; return; }

    : ${1?' zone'}
    local ZONE=$1
    local ENDPOINT=$CLOUDFLARE_ENDPOINT_ROOT/zones/$ZONE/dns_records
    local cmd="curl -X GET $ENDPOINT `cloudflare_basic_header`"
    eval "$cmd | python -mjson.tool"
     
}


cloudflare_update_dns() {
    [[ -z "$CLOUDFLARE_ENDPOINT_ROOT" ]] && { echo "Favor executar ct_env_file_load aonde contem o .env"; return; }

    : ${1?' zone'}
    : ${2?' dns_id'}
    : ${3?' subdomain_name'}
    : ${4?' ip_address'}
    : ${5?'true'}

    local ENDPOINT=$CLOUDFLARE_ENDPOINT_ROOT/zones/$1/dns_records/$2
    local DATA='{ "type":"A", "name":"'$3'", "content":"'$4'", "ttl":3600, "proxied":'$5' }'
    local cmd="curl -X PUT $ENDPOINT `cloudflare_basic_header` --data '$DATA'"
    eval "$cmd | python -mjson.tool"
}




[[ -f /usr/local/bin/cloudflared ]] || { 

    # https://developers.cloudflare.com/cloudflare-one/faq/cloudflare-tunnels-faq/#how-can-i-troubleshoot-a-tunnel-that-was-configured-from-the-zero-trust-dashboard
    ct_cloudflared_install() {
        curl -L --output /tmp/cloudflared.deb https://github.com/cloudflare/cloudflared/releases/latest/download/cloudflared-linux-amd64.deb
        sudo dpkg -i /tmp/cloudflared.deb
    }
    
    return ; 
}


ct_cloudflared_tunnel_proxy_modemZTE() {
    cloudflared tunnel --url http://192.168.0.1
}

ct_cloudflared_tunnel_proxy_RoteadorWav() {
    cloudflared tunnel --url http://192.168.10.1
}

# Configuração para gerenciamento Local: https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/configure-tunnels/local-management/configuration-file/

ct_cloudflared_service_install() {
    : ${1?' api-key'}
    sudo cloudflared service install $1
}


function ct_cloudflared_tunnel_login {
    if [ -f "$HOME/.cloudflared/cert.pem" ]; then
        echo "Você já está logado no Cloudflare. Arquivo '$HOME/.cloudflared/cert.pem' foi encontrado"
    else
        echo "Realizando login no Cloudflare"
        cloudflared tunnel login
    fi
}


function ct_cloudflared_tunnel_listar {
    echo "Listando todos os túneis disponíveis:"
    cloudflared tunnel list
}

function ct_cloudflared_tunnel_criar {
    echo "Criando um novo túnel:"
    read -p "Nome do túnel: " tunnel_name
    cloudflared tunnel create $tunnel_name
}

function ct_cloudflared_tunnel_editar {
    ct_cloudflared_tunnel_listar
    read -p "Selecione o número do túnel a ser editado: " tunnel_number
    cloudflared tunnel edit $tunnel_number
}

function ct_cloudflared_tunnel_remover {
    ct_cloudflared_tunnel_listar
    read -p "Selecione o número do túnel a ser removido: " tunnel_number
    cloudflared tunnel delete $tunnel_number
}

function ct_cloudflared_tunnel_info {
    tunnels=$(cloudflared tunnel list | awk '{print $1}')
    if [ -z "$tunnels" ]; then
        echo "Nenhum túnel disponível para exibir informações."
        return
    fi

    echo "Túneis disponíveis:"
    select tunnel_identifier in $tunnels; do
        if [ -n "$tunnel_identifier" ]; then
            cloudflared tunnel info "$tunnel_identifier"
            break
        else
            echo "Opção inválida, selecione um túnel da lista."
        fi
    done
}

function ct_cloudflared_tunnel_ingress_validate {
    echo "Executando a validação de ingresso do túnel..."
    cloudflared tunnel ingress validate
}

function ct_cloudflared_tunnel_tryCloudflare {
    if [ -z "$1" ]; then
        echo "É necessário fornecer uma URL como argumento."
        return
    fi
    echo "Executando o túnel com a URL: $1"
    cloudflared tunnel --url "$1"
}


# https://developers.cloudflare.com/cloudflare-one/connections/connect-networks/configure-tunnels/local-management/configuration-file/
function ct_cloudflared_tunnel_manage {
    while true; do
        echo "Opções:"
        echo "1) Login no Cloudflare"
        echo "2) Listar túneis"
        echo "3) Criar túnel"
        echo "4) Editar túnel"
        echo "5) Remover túnel"
        echo "6) Obter informações sobre um túnel"
        echo "7) Validar ingresso do túnel"
        echo "8) Sair"

        read -p "Escolha uma opção: " choice

        case $choice in
            1) ct_cloudflared_tunnel_login ;;
            2) ct_cloudflared_tunnel_listar ;;
            3) ct_cloudflared_tunnel_criar ;;
            4) ct_cloudflared_tunnel_editar ;;
            5) ct_cloudflared_tunnel_remover ;;
            6) ct_cloudflared_tunnel_info ;;
            7) ct_cloudflared_tunnel_ingress_validate ;;
            8) break ;;
            *) echo "Opção inválida, tente novamente."
        esac
    done
}


