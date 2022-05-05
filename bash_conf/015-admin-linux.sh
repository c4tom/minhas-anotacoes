

# Debian/Ubuntu

ct_adm_user_disable_login() {
   : ${1?: '<system user>'}
   echo_and_run sudo chsh -s /bin/false $1
}


ct_adm_user_create_jailed_in_home() {
   : ${1? "<username>"}
   sudo useradd -s /bin/rbash -m -d /home/$1 $1
}

ct_adm_how_process_running_port () {
   : ${1?: '<port>'}


   echo_and_run sudo lsof -i :$1

   local cmd="sudo netstat -ltnp | grep -w ':$1'"
   echoColor "$BYellow""command>$IPurple $cmd"
   "$($cmd)"
   # TODO corrigir
}

