[[ $HASAPT = false ]] && { return; }

# Reinstalar bash completion
ct_apt_installBashComplete() {
  sudo apt-get install --reinstall bash-completion
}

# pacotes necessários para instalar QT e KDE
ct_apt_installPackagesForCompileQTandKDE() {
  sudo apt install
}

ct_apt_listarPacotesInstalados() {
  apt list --installed
}

ct_apt_listarPacotesInstaladosManualmente() {
  apt-mark showmanual
}

# https://askubuntu.com/questions/17823/how-to-list-all-installed-packages
# Clonar um sistema para outro, fazendo backup dos pacotes e reempacotando
#
# Install
#
# sudo apt-get install apt-clone
#
#Make backup
#
# sudo apt-clone clone path-to/apt-clone-state-ubuntu-$(lsb_release -sr)-$(date +%F).tar.gz
#
#Restore backup
#
# sudo apt-clone restore path-to/apt-clone-state-ubuntu.tar.gz
#
#Restore to newer release:
#
# sudo apt-clone restore-new-distro path-to/apt-clone-state-ubuntu.tar.gz $(lsb_release -sc)
#
ct_apt_clone_sistema() {
  # util para criar uma instalação igual e outro lugar
  sudo apt-clone clone --with-dpkg-repack clone/apt-clone-state-ubuntu-$(lsb_release -sr)-$(date +%F).tar.gz
}
