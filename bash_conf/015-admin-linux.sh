
[[ `isWin` != "1" ]] || { return ; }

# Debian/Ubuntu

ct_adm_user_disable_login() {
   : ${1?: '<system user>'}
   echo_and_run sudo chsh -s /bin/false $1
}


ct_adm_user_create_jailed_in_home() {
   : ${1? "<username>"}
   sudo useradd -s /bin/rbash -m -d /home/$1 $1
}


[[ ! -f $(type -P lsof) ]] || { 

   ct_adm_how_process_running_port () {
      : ${1?: '<port>'}


      echo_and_run sudo lsof -i :$1

      local cmd="sudo netstat -ltnp | grep -w ':$1'"
      echoColor "$BYellow""command>$IPurple $cmd"
      "$($cmd)"
      # TODO corrigir
   }
}



ct_swap_create() {
   local SWAP_LOCATION=${1:-"/swapfile"}
   local SIZE_BYTES=${2:-"3145728"}
   cat /proc/sys/vm/swappiness
   sudo sysctl vm.swappiness=10
   sudo dd if=/dev/zero of=$SWAP_LOCATION bs=1024 count=$SIZE_BYTES
   sudo chmod 600 $SWAP_LOCATION

   sudo mkswap $SWAP_LOCATION
   sudo swapon $SWAP_LOCATION

   echo "$SWAP_LOCATION swap swap defaults 0 0" | sudo tee --append /etc/fstab

   sudo swapon --show

   sudo free -h
}