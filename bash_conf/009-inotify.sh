# Utilitários para monitoramento de arquivos e diretórios usando inotify
#
# Este arquivo fornece funções para monitorar mudanças em tempo real
# em arquivos e diretórios usando o inotify-tools

[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/bin/inotifywait ]] || {
   [[ $HASAPT = false ]] && { return; }
   # Instala as ferramentas inotify-tools
   #
   # Uso: ct_install_inotify-tools
   #
   # Retorna:
   #   0 em caso de sucesso na instalação
   ct_install_inotify-tools() {
      sudo apt install inotify-tools
   }
   return;
}

# Monitora recursivamente um diretório para mudanças
#
# Esta função monitora continuamente um diretório e seus subdiretórios
# para eventos de modificação, criação, deleção e movimentação de arquivos
#
# Uso: ct_monitorar_pasta <diretório>
#
# Parâmetros:
#   diretório - Caminho do diretório a ser monitorado
#
# Retorna:
#   Exibe eventos de mudança em tempo real
ct_monitorar_pasta() {
   : ${1?' informe a pasta'}
   while true; do
      inotifywait -e modify,create,delete,move -r $1
   done
}

# Monitora recursivamente um diretório mostrando o caminho completo
#
# Similar a ct_monitorar_pasta, mas mostra o caminho completo do arquivo
# e o tipo de evento ocorrido
#
# Uso: ct_monitorar_pasta_mostrando_linha <diretório>
#
# Parâmetros:
#   diretório - Caminho do diretório a ser monitorado
#
# Retorna:
#   Exibe eventos de mudança com o caminho completo do arquivo
ct_monitorar_pasta_mostrando_linha() {
   : ${1?' informe a pasta'}
   inotifywait -m -r --format '%w%f %e' "$1" | while read line; do echo "$line"; done
}