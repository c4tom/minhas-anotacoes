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
    aptadd libvmdk-utils gparted guestmount bindfs
    # System Utils
    aptadd iotop parallel tree
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
    # Cloud Tools
    aptadd rclone
    # Dev Tools
    aptadd strace pluma vim
    # audio tools
    aptadd pavucontrol
    # X utils
    aptadd flameshot bleachbit xdotool
    # Security
    aptadd firejail firetools
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