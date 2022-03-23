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
    aptadd strace pluma vim
    # audio tools
    aptadd pavucontrol
    # X utils
    aptadd flameshot bleachbit xdotool copyq
    # Security
    aptadd firejail firetools dsniff 
    # Java Dev Utils
    aptadd maven
    # Web Dev
    aptadd php-cli

    sudo apt-get install $APT_PKG
        
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