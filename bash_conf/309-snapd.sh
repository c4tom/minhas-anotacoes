
[[ -f /usr/bin/snap ]] || { 
    # https://docs.snapcraft.io/core/usage
    # https://docs.snapcraft.io/core/install-ubuntu
    # https://snapcraft.io/store (Loja)
    ct_snapdInstall() {
        sudo apt-get install snapd
    }
    return ; 
}

# if you need move cache to another partition, it's needed move "snaps" and "cache" together
ct_snap_move_cache_another_partition() {
    : ${1?' inform location, please without spaces. Example: /diskD/snap'}

    sudo service snapd stop;
    sudo mkdir -p "$1/cache"
    sudo mv /var/lib/snapd/snaps "$1"
    sudo rm -fr /var/lib/snapd/cache
    sudo ln -sf "$1/cache" /var/lib/snapd/cache

    sudo service snapd start;
}


ct_snapInstallAndroidStudio() {
    sudo apt-get install qemu-kvm

    #TODO: adicionar usuario ao grupo KVM

    sudo snap install android-studio --classic

    sudo usermod -a -G kvm $USER
}

ct_snapInstallAllDesenv() {
    local CLASSIC="android-studio 
        code-insiders 
        freemind
        intellij-idea-community intellij-idea-ultimate phpstorm pycharm-educational rider 
        opera
        postman
        powershell 
        speedy-duplicate-finder
        flutter"
    local EDGE=" notekit"

    for i in $CLASSIC
        do
            sudo snap install $i --classic 
        done
    
    for i in $EDGE
        do 
            sudo snap install $i --edge
        done
}

ct_snap_getSystemInfo() {
	local finfo=/tmp/info
	echo -e "lsb_release -a\n" > $finfo
	lsb_release -a >> $finfo
	echo -e "\nsnap version\n" >> $finfo
	echo "`snap version`" >> $finfo
	echo -e "\n" >> $finfo

	cat $finfo
}