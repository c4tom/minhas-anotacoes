
[[ -f /usr/bin/snap ]] || { return ; }

# https://docs.snapcraft.io/core/usage
# https://docs.snapcraft.io/core/install-ubuntu
# https://snapcraft.io/store (Loja)
ct_snapdInstall() {
    sudo apt-get install snapd
}