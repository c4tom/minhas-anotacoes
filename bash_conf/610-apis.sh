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

    local ENDPOINT=$CLOUDFLARE_ENDPOINT_ROOT/zones/$1/dns_records/$2
    local DATA='{ "type":"A", "name":"'$3'", "content":"'$4'", "ttl":3600, "proxied":true }'
    local cmd="curl -X PUT $ENDPOINT `cloudflare_basic_header` --data '$DATA'"
    eval "$cmd | python -mjson.tool"
}


