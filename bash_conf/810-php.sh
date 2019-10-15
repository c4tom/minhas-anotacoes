
[[ -f /usr/bin/composer ]] || { return ; }

ct_ComposerSpeedUp() {
    sudo sh -c "echo 'precedence ::ffff:0:0/96 100' >> /etc/gai.conf"
    composer global require hirak/prestissimo
}