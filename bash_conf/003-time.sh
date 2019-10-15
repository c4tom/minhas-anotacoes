

ct_timeCorrigirLinuxEWindows() {
    xdg-open 'https://www.edivaldobrito.com.br/como-corrigir-diferencas-de-tempo-entre-o-ubuntu-e-o-windows-em-sistema-com-dual-boot/'
}

ct_datehoraAtualizaComNTP() {
    sudo ntpdate 1.ro.pool.ntp.org
}