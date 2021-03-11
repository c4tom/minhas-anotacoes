
# Ajuda para corrigir horas em dual boot do linux e windows
ct_time_corrigirLinuxEWindows() {
    xdg-open 'https://www.edivaldobrito.com.br/como-corrigir-diferencas-de-tempo-entre-o-ubuntu-e-o-windows-em-sistema-com-dual-boot/'
}

# Sincroniza data e hora do linux com o servidor NTP
ct_date_sincWithNTP() {
    sudo ntpdate 1.ro.pool.ntp.org
}


ct_date_now_y-m-d() {
    date +%F
}

ct_date_now_ymdhms() {
    date '+%Y%m%d%H%M%S'
}

ct_date_now_hms() {
    date '+%H%M%S'
}