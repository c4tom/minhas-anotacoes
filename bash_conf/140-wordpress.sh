
# https://kinsta.com/pt/blog/seguranca-wordpres/
# https://kinsta.com/pt/blog/plugins-de-seguranca-wordpress/



if [[ ! -f /usr/bin/wp ]]
then
    # install https://wp-cli.org/
	ct_wp_cli_install()
	{
        cd /tmp
        curl -O https://raw.githubusercontent.com/wp-cli/builds/gh-pages/phar/wp-cli.phar
        # only root can execute
        chmod +500 wp-cli.phar
        sudo mv wp-cli.phar /usr/bin/wp
	}
fi


ct_wp_setPermissionDirsFiles() {
  : ${1?' <path>'}
   find "$1" -type d -exec chmod 755 {} \;
   find "$1" -type f -exec chmod 644 {} \;
}

if [[ ! -f /etc/bash_completion.d/wp-completion ]] 
then
  ct_wp_install_bash_completion() {
    wget https://raw.githubusercontent.com/wp-cli/wp-cli/v2.4.0/utils/wp-completion.bash -O /tmp/wp-completion
    sudo cp /tmp/wp-completion /etc/bash_completion.d/
  }
fi




## CLI commands

ct_wp_transient_delete_byPrefix() {
  : ${1?' <prefix like: ipz* ipz_ or nono_?>'}

  for i in $(wp transient list --search=ipz_*  --fields=name --format=csv | sed -n '1d;p'); 
  do 
    echo "DEL key=$i"; wp transient delete $i; 
  done
}



## WP Users

ct_wp_changePasswordForUserID() {
  wp user list

  echo "Qual ID?"
  read op

  password=$(askToPassword "Digite a senha: ")

  wp user update $op --user_pass=$password
}