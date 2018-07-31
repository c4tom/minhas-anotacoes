

# https://www.tecmint.com/install-nodejs-npm-in-centos-ubuntu/
# Veja tambem: https://nodejs.org/en/download/
nodejsInstallLinuxMint() {
	sudo curl -sL https://deb.nodesource.com/setup_8.x | sudo -E bash -
	sudo apt-get install nodejs
}

[[ -f /usr/bin/nodejs ]] || { return ; }

# Tools
# https://www.npmjs.com/package/sitemap-generator-cli
#	