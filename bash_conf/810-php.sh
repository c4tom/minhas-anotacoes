
[[ ! -f /usr/bin/composer ]] || {
    ct_ComposerSpeedUp() {
        sudo sh -c "echo 'precedence ::ffff:0:0/96 100' >> /etc/gai.conf"
        composer global require hirak/prestissimo
    }

}

[[ ! -f /desenv/php/phpcs.phar ]] || {
    alias phpcs=/desenv/php/phpcs.phar
}
