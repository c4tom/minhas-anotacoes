

# Debian/Ubuntu

ct_adm_disable_user_login() {
   : ${1?: '<system user>'}
   echo_and_run sudo chsh -s /bin/false $1
}

ct_adm_how_process_running_port () {
   : ${1?: '<port>'}


   echo_and_run sudo lsof -i :$1

   local cmd="sudo netstat -ltnp | grep -w ':$1'"
   echoColor "$BYellow""command>$IPurple $cmd"
   "$(eval $cmd)"
   # TODO corrigir
}