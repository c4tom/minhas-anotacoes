ct_squid_add_user_and_group() {
    sudo addgroup --system squid
    sudo adduser --system --no-create-home --disabled-login --disabled-password --ingroup squid squid
}


### Proxy ###
ct_proxyEnable() {
    export http_proxy=http://localhost:3128/
    export https_proxy=http://localhost:3128/
}

ct_proxyDisable() {
    unset http_proxy
    unset https_proxy
}

proxyON() {
    if [[ ! $http_proxy ]]
    then
        if [ $(ct_net_checkLocalhostPortIsListen 3128) = "open" ]
        then
            echo "Proxy ON (localhost)"          
            ct_proxyEnable
            echo "Execute: ct_fwTransparentProxySquidSet"
        fi
    fi
}

proxyOFF() {
    ct_proxyDisable
}