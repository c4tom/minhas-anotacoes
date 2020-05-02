
[[ -f /usr/bin/snap ]] || { return ; }

# https://docs.snapcraft.io/core/usage
# https://docs.snapcraft.io/core/install-ubuntu
# https://snapcraft.io/store (Loja)
ct_snapdInstall() {
    sudo apt-get install snapd
}

ct_snapInstallAndroidStudio() {
    sudo apt-get install qemu-kvm

    #TODO: adicionar usuario ao grupo KVM

    sudo snap install android-studio --classic

    sudo usermod -a -G kvm $USER
}

ct_snapInstallAllDesenv() {
    local CLASSIC="android-studio code-insiders intellij-idea-community intellij-idea-ultimate phpstorm pycharm-educational rider"
    local EDGE=" node"

    for i in $CLASSIC
        do
            sudo snap install $i --classic 
        done
    
    for i in $EDGE
        do 
            sudo snap install $i --edge
        done
}