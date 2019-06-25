
[[ ! -f "/usr/bin/grub-customizer" ]] || { 
    ct_grubInstalCustomizer() {
        sudo add-apt-repository ppa:danielrichter2007/grub-customizer
        sudo apt-get update
        sudo apt-get install grub-customizer
    }
}