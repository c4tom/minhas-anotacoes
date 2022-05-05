[[ -f /usr/bin/snap ]] || {
    # https://docs.snapcraft.io/core/usage
    # https://docs.snapcraft.io/core/install-ubuntu
    # https://snapcraft.io/store (Loja)

    [[ $HASAPT = false ]] && { return; }

    ct_snapd_beforeInstall() {
        echo "
[Unit]
Description=bind mount snapd from /dados/.snapd to /var/lib/snapd

[Mount]
What=/dados/.snapd
Where=/var/lib/snapd
Type=fuse.bindfs
Options=force-user=root,force-group=root,perms=0775:ug+D

[Install]
WantedBy=multi-user.target
RequiredBy=snapd.service        
" | sudo tee -a /etc/systemd/system/var-lib-snapd.mount

    sudo systemctl enable var-lib-snapd.mount
    }


    ct_snapdInstall() {
        #On Linux Mint 20, /etc/apt/preferences.d/nosnap.pref needs to be removed before Snap can be installed. This can be accomplished from the command line:

        sudo rm /etc/apt/preferences.d/nosnap.pref
        sudo apt update        
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


__snapInstallAndroidStudio() {
    sudo apt-get install qemu-kvm

    #TODO: adicionar usuario ao grupo KVM

    sudo snap install android-studio --classic

    sudo usermod -a -G kvm $USER
}

__snap_pkgClassic() {
    echo "
        android-studio code-insiders netbeans
        chromium-ffmpeg
        freemind
        intellij-idea-community intellij-idea-ultimate phpstorm pycharm-educational rider 
        opera
        postman
        powershell
        speedy-duplicate-finder
        insomnia
        libreoffice
        kompozer
        skrooge
        snapcraft
        dbeaver-ce
        flutter"
}

ct_snap_pkgEdge() {
    echo " notekit"
}

ct_snapDownloadAllDesenv() {
    local CLASSIC=$(__snap_pkgClassic)
    local EDGE=$(__snap_pkgEdge)

    for i in $CLASSIC
        do
            snap download $i 
        done
    
    for i in $EDGE
        do 
            snap download $i
        done
}

ct_snapInstallAllDesenv() {
    local CLASSIC=$(__snap_pkgClassic)
    local EDGE=$(__snap_pkgEdge)

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
	echo "$(snap version)" >> $finfo
	echo -e "\n" >> $finfo

	cat $finfo
}

ct_snap_change_location() {
    ##############################################################################
    # Take Care this section may break the System !!!
    ##############################################################################
    ##Move snap folder to Home instead of root.
    #Create the directory : you can change the location
    mkdir -p /home/$USER/snap/snapd

    #Copy the data
    sudo rsync -avzP /var/lib/snapd/  /home/$USER/snap/snapd/

    #Do backups
    sudo mv /var/lib/snapd /var/lib/snapd.bak
    sudo cp /etc/fstab /etc/fstab.bak

    #Change fstab (Change $USER with your name or change the path totally)
    echo "/home/$USER/snap/snapd /var/lib/snapd none bind 0 0" | sudo tee -a /etc/fstab

    #remount fstab Or reboot.
    sudo mkdir /var/lib/snapd
    sudo mount -a

    if ls  /var/lib/snapd/ | grep snaps
    then
        echo "Re-mounting snapd folder is done successfully. !!!!"
        sudo rm -rf /var/lib/snapd.bak
    else
        echo "WARNING : Re-mounting snapd folder failed, please revert !!!!! "
        echo "WARNING : Re-mounting snapd folder failed, please revert !!!!! "
        echo "WARNING : Re-mounting snapd folder failed, please revert !!!!! "
        echo "WARNING : Re-mounting snapd folder failed, please revert !!!!! "
        echo "WARNING : Re-mounting snapd folder failed, please revert !!!!! "

        # Trying to revert automatically
        sudo cp /etc/fstab.bak /etc/fstab

        sudo mount -a
        sudo umount /var/lib/snapd

        sudo mv /var/lib/snapd.bak /var/lib/snapd

        echo "Files located at ~/snap/snapd should be removed, but are kept for
        recovery until you, manually reboot the system and make sure the service
        is running correctly. Then you can manually remove the folder ~/snap/snapd
        !!!!!!!!!!!!!!, you should do that manually."

    fi
    ##############################################################################
    # Take care the previous section may break the System !!!
    ##############################################################################
}


ct_snap_log() {
    journalctl -e --no-pager -u snapd
}

ct_snap_debug_changes() {
    for chg in $(snap changes | awk '{print $1}' | grep -Po '[0-9]+'); do
        echo ">>> $chg <<<"
        snap debug timings $chg
    done
}