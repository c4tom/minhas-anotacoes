
# Ajuda para corrigir horas em dual boot do linux e windows
ct_time_corrigirLinuxEWindows() {
    xdg-open 'https://www.edivaldobrito.com.br/como-corrigir-diferencas-de-tempo-entre-o-ubuntu-e-o-windows-em-sistema-com-dual-boot/'
}

# Sincroniza data e hora do linux com o servidor NTP
ct_date_sincWithNTP() {
    sudo ntpdate 1.ro.pool.ntp.org
}