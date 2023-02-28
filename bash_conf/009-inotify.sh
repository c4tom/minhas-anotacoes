[[ `isWin` != "1" ]] || { return ; }

[[ -f /usr/bin/inotifywait ]] || {
   [[ $HASAPT = false ]] && { return; }
   ct_install_inotify-tools() {
      sudo apt install inotify-tools
   }
   return;
}

# https://stackoverflow.com/questions/8699293/how-to-monitor-a-complete-directory-tree-for-changes-in-linux

ct_monitorar_pasta() {
   : ${1?' informe a pasta'}
   while true; do
      inotifywait -e modify,create,delete,move -r $1
   done
}

ct_monitorar_pasta_mostrando_linha() {
   : ${1?' informe a pasta'}
   inotifywait -m -r --format '%w%f %e' "$1" | while read line; do echo "$line"; done
}