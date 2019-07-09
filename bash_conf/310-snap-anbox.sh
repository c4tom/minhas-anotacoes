
## Requer pacote snapd
[[ -f /usr/bin/snap ]] || { return ; }

# https://github.com/anbox/anbox/blob/master/docs/install.md
# https://docs.anbox.io/userguide/install.html
# https://linuxconfig.org/how-to-install-anbox-and-run-android-apps-in-linux

ct_anboxInstall() {
    sudo add-apt-repository ppa:morphis/anbox-support
    sudo apt update
    sudo apt install anbox-modules-dkms

    sudo modprobe ashmem_linux
    sudo modprobe binder_linux


    ls -1 /dev/{ashmem,binder}

    sudo snap install --devmode --beta anbox

    snap info anbox
}


ct_anboxRestartService() {
    sudo systemctl restart snap.anbox.container-manager.service
}

#https://github.com/Debyzulkarnain/anbox-bridge/blob/master/anbox-bridge.sh
ct_anboxBridge() {
    sudo /usr/bin/anbox-bridge.sh start
}

ct_anboxUninstall(){
    sudo snap remove anbox
    sudo apt install ppa-purge
    sudo ppa-purge ppa:morphis/anbox-support
}