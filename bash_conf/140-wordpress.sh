
# https://kinsta.com/pt/blog/seguranca-wordpres/
# https://kinsta.com/pt/blog/plugins-de-seguranca-wordpress/



if [[ ! -f /usr/bin/wp ]]
then
    # install https://wp-cli.org/
	ct_wp_install()
	{
        cd /tmp
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        # only root can execute
        chmod +500 wp-cli.phar
        sudo mv wp-cli.phar /usr/bin/wp
	}
fi