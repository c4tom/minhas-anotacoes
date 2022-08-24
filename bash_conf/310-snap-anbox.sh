[[ `isWin` == "1" ]] || { return ; }

## Requer pacote snapd
[[ -f /usr/bin/snap ]] || { return ; }

# https://github.com/anbox/anbox/blob/master/docs/install.md
# https://www.howtogeek.com/760044/how-to-run-android-apps-on-linux/

# FOR Mint 20.3
ct_anboxInstall() {
    sudo snap install --devmode --beta anbox
    sudo apt install wget curl lzip tar unzip squashfs-tools

    echo "Install PLAY Store"
    wget https://raw.githubusercontent.com/geeks-r-us/anbox-playstore-installer/master/install-playstore.sh
    chmod +x install-playstore.sh
    ./install-playstore.sh

    snap info anbox

    echo "Run Now anbox.appmgr"
}


ct_anboxUninstall(){
    sudo snap remove anbox
}