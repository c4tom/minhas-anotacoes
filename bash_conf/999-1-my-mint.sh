# Tudo que fiz no meu linux mint
# * Com SSD

# Pacotes que instalei
mymint_install_packages() {

    sudo apt-get install afflib-tools calibre ffmpeg filezilla gparted handbrake iotop parallel links maven obs-studio pandoc pencil php-cli remmina rclone scite sshfs strace tree vim vokoscreen vmdkmount w3m xdotool
}

# afflib-tools -> affuse

# mover .cache se estiver usando ssd, para outro disco (rigido)
mymint_home_move_cache() {
    : ${1?' <pasta de destino>'}
    echo mv ~/.cache " $1"
}