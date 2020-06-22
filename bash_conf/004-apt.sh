
[[ -f /usr/local/bin/apt ]] || { return ;  }


# Reinstalar bash completion
ct_apt_installBashComplete() {
  sudo apt-get install --reinstall bash-completion
}

ct_apt_installPackagesForCompileQTandKDE() {
    sudo apt install
}

