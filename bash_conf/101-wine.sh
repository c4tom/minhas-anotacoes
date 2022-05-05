

[[ $HASAPT = false ]] && { return; }

# https://wiki.winehq.org/Ubuntu
ct_wine_install_last() {
   sudo dpkg --add-architecture i386 
   wget -nc https://dl.winehq.org/wine-builds/winehq.key
   sudo apt-key add winehq.key
   sudo apt update
   
   sudo apt install --install-recommends winehq-stable
}