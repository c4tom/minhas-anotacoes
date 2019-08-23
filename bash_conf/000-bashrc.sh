export PATH=$PATH:/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin:/usr/games:/usr/local/games:/snap/bin:/desenv/java/apache-cxf-3.3.3/bin

#[[ $(id -u) -eq 0 ]] || { echo >&2 "Must be root to run this function"; return; }

alias gksu='pkexec env DISPLAY=$DISPLAY XAUTHORITY=$XAUTHORITY'