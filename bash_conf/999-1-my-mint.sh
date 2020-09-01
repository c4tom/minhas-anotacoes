# Tudo que fiz no meu linux mint
# * Com SSD

# Pacotes que instalei
mymint_install_packages() {

    sudo apt-get install afflib-tools calibre ffmpeg filezilla gparted handbrake iotop parallel links maven obs-studio pandoc php-cli libvmdk-utils remmina rclone scite sshfs strace tree vim vokoscreen w3m xdotool bleachbit pavucontrol flameshot bindfs pluma firejail firetools \
        fdupes \ # find duplicates files
        pigz \ # compressao, pode usar com tar
        command-not-found  # find suggest command to install
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