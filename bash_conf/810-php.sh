[[ ! -f /usr/bin/composer ]] || {
    ct_php_composerSpeedUp() {
        # Melhora a resolução de endereços IPv4 em ambientes que usam IPv6
        sudo sh -c "echo 'precedence ::ffff:0:0/96 100' >> /etc/gai.conf"

        # Instala o plugin Prestissimo globalmente usando o Composer
        composer global require hirak/prestissimo
    }

}

[[ ! -f /desenv/php/phpcs.phar ]] || {
    alias phpcs=/desenv/php/phpcs.phar
}

[[ -f /usr/bin/composer ]] || {
    php_composer_install() {
        # Verifica se o Composer já está instalado
        # Baixa e instala o Composer
        php -r "copy('https://getcomposer.org/installer', 'composer-setup.php');"
        php composer-setup.php --install-dir=/usr/bin --filename=composer
        php -r "unlink('composer-setup.php');"

    }
    return
}
