
isWSL() {
  local uname=`uname -r`
  if [[ $uname == *"Microsofst"* ]]; then 
    echo 1
    else
    echo 0
  fi
}

[[ "`isWSL`" = "0" ]] || { return ; }

wsl_aptInstallBashComplete() {
  sudo apt-get install --reinstall bash-completion
}

