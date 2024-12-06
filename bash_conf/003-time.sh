# Funções para manipulação de data e hora no Linux
#
# Este arquivo contém funções úteis para sincronização de tempo
# e formatação de data/hora no sistema Linux

# Abre uma página com instruções para corrigir diferenças de hora
# entre Linux e Windows em sistemas com dual boot
#
# Uso: ct_time_corrigirLinuxEWindows
#
# Retorna:
#   Abre o navegador com a página de instruções
ct_time_corrigirLinuxEWindows() {
    xdg-open 'https://www.edivaldobrito.com.br/como-corrigir-diferencas-de-tempo-entre-o-ubuntu-e-o-windows-em-sistema-com-dual-boot/'
}

# Sincroniza o relógio do sistema com um servidor NTP
#
# Esta função usa o ntpdate para sincronizar a data e hora
# do sistema com um servidor NTP da Romania
#
# Uso: ct_date_sincWithNTP
#
# Retorna:
#   0 em caso de sucesso, diferente de 0 em caso de erro
ct_date_sincWithNTP() {
    sudo ntpdate 1.ro.pool.ntp.org
}

# Retorna a data atual no formato YYYY-MM-DD
#
# Uso: ct_date_now_y-m-d
#
# Retorna:
#   String com a data no formato YYYY-MM-DD
ct_date_now_y-m-d() {
    date +%F
}

# Retorna data e hora atual no formato YYYYMMDDHHMMSS
#
# Uso: ct_date_now_ymdhms
#
# Retorna:
#   String com data e hora no formato YYYYMMDDHHMMSS
ct_date_now_ymdhms() {
    date '+%Y%m%d%H%M%S'
}

# Retorna hora atual no formato HHMMSS
#
# Uso: ct_date_now_hms
#
# Retorna:
#   String com a hora no formato HHMMSS
ct_date_now_hms() {
    date '+%H%M%S'
}