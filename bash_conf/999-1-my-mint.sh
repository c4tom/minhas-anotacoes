# Tudo que fiz no meu linux mint
# * Com SSD

# Pacotes que instalei
mymint_install_packages() {
    local APT_PKG=""

    aptadd() {
        APT_PKG="$APT_PKG $@"
    }    


    aptadd afflib-tools calibre pandoc
    # find duplicates files\
    aptadd fdupes
    # disk vm utils
    aptadd libvmdk-utils gparted bindfs
    # System Utils
    aptadd iotop parallel tree rclone 
    # compressao, pode usar com tar
    aptadd pigz
    # Internet Tools
    aptadd filezilla links w3m sshfs remmina
    # find suggest command to install
    aptadd command-not-found
    # Controlador de Frequencia
    aptadd cpupower-gui
    # Video Utils
    aptadd ffmpeg handbrake obs-studio vokoscreen
    # Music
    aptadd clementine
    # Cloud Tools
    # - Rclone (download via site)
    # Net Tools
    aptadd subnetcalc gnome-nettool netwox traceroute
    # Dev Tools
    aptadd strace pluma vim tmux
    # audio tools
    aptadd pavucontrol
    # X utils
    aptadd flameshot bleachbit xdotool xsel copyq
    # Security
    aptadd firejail firetools dsniff 
    # Java Dev Utils
    aptadd maven
    # Web Dev
    aptadd php-cli

    # Control Panel
    aptadd gnome-control-center

    sudo apt-get install $APT_PKG

    # Criar icone
    echo "[Desktop Entry]
Name[pt]=Aplicações Preferidas
Name[pt_BR]=Contas Online
Name=Preferred Applications
Comment[pt]=Selecione as suas aplicações predefinidas
Comment[pt_BR]=Selecione seus aplicativos padrão
Comment=Select your default applications
Exec=gnome-control-center online-accounts
Icon=preferences-desktop-default-applications
Terminal=false
Type=Application
StartupNotify=true
Categories=GTK;Settings;X-MATE-PersonalSettings;
Keywords[pt]=mate-control-center;MATE;pré-definida;preferida;aplicações;
Keywords=mate-control-center;MATE;default;preferred;applications;
OnlyShowIn=MATE;
" > ~
        
}

# afflib-tools -> affuse

# mover .cache se estiver usando ssd, para outro disco (rigido)
mymint_home_move_cache() {
    : ${1?' <pasta de destino>'}
    echo mv ~/.cache " $1"
}

# How to Show Asterisks While Typing Sudo Password in Linux
mymint_patch_sudoers() {
    sudo sed -i "s/env_reset\$/env_reset,pwfeedback/" /etc/sudoers
}


mymint_install_epson_l355() {

   echo "deb [trusted=yes] http://download.ebz.epson.net/dsc/op/stable/debian/ lsb3.2 main" | sudo tee --append /etc/apt/sources.list.d/epson.list

   apt-key adv --keyserver keyserver.ubuntu.com --recv-keys E5E86C008AA65D56
   sudo apt-get update
   sudo apt-get install Epson-inkjet-printer-201207w

   # http://download.ebz.epson.net/dsc/op/stable/debian/dists/lsb3.2/epson-inkjet-printer-201207w/binary-amd64/epson-inkjet-printer-201207w_1.0.0-1lsb3.2_amd64.deb
}

mymint_after_install_mint() {
    mymint_install_packages
    ct_systemd_add_rc_local
    mymint_install_epson_l355
}

mymint_install_remmina() {
    sudo apt-add-repository ppa:remmina-ppa-team/remmina-next
    sudo apt update
    sudo apt install remmina remmina-plugin-rdp remmina-plugin-secret
}


# https://www.golinuxcloud.com/mount-luks-encrypted-disk-partition-linux/
mymint_encrypt_hdd() {
    lsblk

    echo "Informe qual /dev/sda?, digite: /dev/??????"
    read DEVHDD

    echo "Criando um arquivo chave /root/lukskey"

    sudo dd if=/dev/random bs=32 count=1 of=/root/lukskey

    sudo xxd /root/lukskey

    sudo cryptsetup luksAddKey $DEVHDD /root/lukskey

    echo "Escrevendo em /etc/crypttab"
    echo "secret  $DEVHDD       /root/lukskey" | sudo tee -a /etc/crypttab

    cat /etc/crypttab
}