

# Disable DNS systemd
# https://askubuntu.com/questions/907246/how-to-disable-systemd-resolved-in-ubuntu

ct_systemd_disableDNS() {
    sudo systemctl disable systemd-resolved.service
    sudo service systemd-resolved stop

    /etc/NetworkManager/NetworkManager.conf
    rm /etc/resolv.conf
    sudo service network-manager restart
}

ct_systemd_listEnabledServices() {
    #systemctl list-unit-files | grep enabled
    echo_and_run systemctl list-unit-files --state=enabled
}

ct_systemd_listRunning() {
    #systemctl | grep running
    echo_and_run systemctl list-units --type=service --state=running
}

ct_systemd_runningAndFail(){
    echo_and_run systemctl list-units --type service --state running,failed
}

ct_systemd_stopService() {
    local service_name="$1"
    echo "Parando serviço: ${service_name}" 
    echo_and_run systemctl stop ${service_name}
}

ct_systemd_disableServiceOnStartSystem() {
    local service_name="$1"
    echo "Desabilita serviço no inicio do sistema: ${service_name}" 
    echo_and_run systemctl stop ${service_name}
}