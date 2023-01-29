# Install OLS (Open litespeed)

# Ubuntu/Mint
# https://openlitespeed.org/kb/1-click-install/
# https://www.digitalocean.com/community/tutorials/how-to-install-linux-openlitespeed-mariadb-php-lomp-stack-on-ubuntu-22-04
# https://upcloud.com/resources/tutorials/install-openlitespeed-fast-secure-web-server
ct_install_openlitespeed() {
    wget https://raw.githubusercontent.com/litespeedtech/ols1clk/master/ols1clk.sh && bash ols1clk.sh
    sudo systemctl status lsws
}
