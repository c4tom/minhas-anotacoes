
[[ -f /usr/bin/snap ]] || { return ; }

# https://docs.snapcraft.io/core/usage
# https://docs.snapcraft.io/core/install-ubuntu
# https://snapcraft.io/store (Loja)
ct_snapdInstall() {
    sudo apt-get install snapd
}

ct_snapInstallAndroidStudio() {
    sudo apt-get install qemu-kvm

    sudo snap install android-studio --classic
}

ct_snapInstallAllDesenv() {
    local CLASSIC="code code-insiders eclipse intellij-idea-community intellij-idea-ultimate netbeans node phpstorm powershell pycharm-educational rider "
    local EDGE="dbeaver-ce"

    for i in $CLASSIC
        do
            sudo snap install $i --classic 
        done
    
    for i in $EDGE
        do 
            sudo snap install $i --edge
        done
}