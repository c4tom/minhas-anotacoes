
[[ -f /usr/bin/flatpak ]] || {

    
    return;
}


ct_flatpak_dashboard() {
    echoGreenBlack "Lista de Apps:"
    flatpak list --app --columns=application,size

    echoGreenBlack "Tamanho do Sistema"
    flatpak list --columns=application,size

}