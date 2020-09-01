

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



ct_systemd_add_rc_local() {
    local filerc="/etc/systemd/system/rc-local.service"
    [[ ! -f $filerc ]] || { echo "já existe, você pode editar /etc/rc.local"; return; }

    echo "[Unit]
 Description=/etc/rc.local Compatibility
 ConditionPathExists=/etc/rc.local

[Service]
 Type=forking
 ExecStart=/etc/rc.local start
 TimeoutSec=0
 StandardOutput=tty
 RemainAfterExit=yes
 SysVStartPriority=99

[Install]
 WantedBy=multi-user.target" | sudo tee --append $filerc

echo "" | sudo tee --append /etc/rc.local && sudo chmod + /etc/rc.local && sudo systemctl enable rc-local

echo "Editar /etc/rc.local"

echo ""

}

ct_systemd_list_dependency() {
    echo_and_run sudo systemctl list-dependencies 
}

ct_systemd_critical_chain() {
    echo_and_run systemd-analyze critical-chain network.target local-fs.target
}

ct_systemd_status() {
    echo_and_run sudo systemctl status
}