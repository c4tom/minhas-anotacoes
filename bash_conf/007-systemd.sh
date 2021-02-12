

# Disable DNS systemd
# https://askubuntu.com/questions/907246/how-to-disable-systemd-resolved-in-ubuntu

ct_systemd_disableDNS() {
    echo_and_run sudo systemctl disable systemd-resolved.service
    echo_and_run sudo service systemd-resolved stop

    echo_and_run cat /etc/NetworkManager/NetworkManager.conf
    rm /etc/resolv.conf
    echo_and_run sudo service network-manager restart
}

ct_systemd_listEnabledServices() {
    #systemctl list-unit-files | grep enabled
    echo_and_run sudo systemctl list-unit-files --state=enabled
}

ct_systemd_listRunning() {
    #systemctl | grep running
    echo_and_run sudo systemctl list-units --type=service --state=running
}

ct_systemd_runningAndFail(){
    echo_and_run sudo systemctl list-units --type service --state running,failed
}

ct_systemd_stopService() {
    : ${1?' dns'}
    echo "Parando serviço: ${1}" 
    echo_and_run sudo systemctl stop ${1}
}

ct_systemd_disableServiceOnStartSystem() {
    local service_name="$1"
    echo "Desabilita serviço no inicio do sistema: ${service_name}" 
    echo_and_run sudo systemctl stop ${service_name}
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



### Servicos

ct_systemd_cockpit_start() {
    echo_and_run sudo systemctl start cockpit.socket
    echo_and_run sudo systemctl enable cockpit.socket
}

ct_systemd_cockpit_stop() {
    echo_and_run sudo systemctl stop cockpit.socket
    echo_and_run sudo systemctl disable cockpit.socket
}