#Node JS - Node.js is a platform built on Chrome's JavaScript runtime for easily building fast, scalable network applications. Real-Time services (Chat, Games etc)
#NPM is a package manager. Typically this software is installed to build Node applications.

#It let's you install software (libraries, plugins, frameworks and applications).
# https://www.tecmint.com/install-nodejs-npm-in-centos-ubuntu/
# Veja tambem: https://nodejs.org/en/download/

if [[ ! -f $(type -p npm) ]] 
then
	[[ $HASAPT = false ]] && { return; }
	ct_nodejs_installInLinuxMint() {
		sudo curl -sL https://deb.nodesource.com/setup_14.x | sudo -E bash -
		sudo apt-get install nodejs
	}
fi

export NPM_PREFIX=/desenv/node_global
export PATH=$PATH:$NPM_PREFIX/bin

### SETAR minhas configuracoes

ct_npm_setar_minhas_configuracoes() {
	# configuração global para instalação globais
	npm config set prefix $NPM_PREFIX

	npm config set cache /dados/node_cache

	ct_npm_corrigeISSUER_CERT_LOCALLY
}


# Tools
# https://www.npmjs.com/package/sitemap-generator-cli
#	

ct_npm_corrigeISSUER_CERT_LOCALLY() {
	
	#npm ERR! code UNABLE_TO_GET_ISSUER_CERT_LOCALLY
	#npm ERR! errno UNABLE_TO_GET_ISSUER_CERT_LOCALLY
	#npm ERR! request to https://registry.npmjs.org/mime-db/-/mime-db-1.40.0.tgz failed, reason: unable to get local issuer certificate
	npm config set registry http://registry.npmjs.org/

	#Error: unable to get local issuer certificate
	#Error: unable to get local issuer certificate
    #  at TLSSocket.onConnectSecure (_tls_wrap.js:1177:34)
    #  at TLSSocket.emit (events.js:193:13)
    #  at TLSSocket._finishInit (_tls_wrap.js:668:8)
	npm config set strict-ssl false
}

# Gera versão do sistema, npm e node 
ct_node_npm_linux_info_git_commit() {
	HELPTXT "Gerar info para escrever num forum/issue"
	ct_help $1

	local finfo=/tmp/info
	echo -e "lsb_release -a\n" > $finfo
	lsb_release -a >> $finfo
	echo -e "\nnpm -v  : `npm -v`" >> $finfo
	echo "node -v  : `node -v`" >> $finfo
	echo -e "\n" >> $finfo

	echo "git log -1 | grep commit " >> $finfo
	git log -1 | grep commit >> $finfo

	cat $finfo
}

# instala um ambiente de desenvolvimento, requisito: npm nodejs e vscode
ct_nodejs_vscode_complementos() {
	# gerar um ambiente de desenvolvimento vscode + node + npm

	# instalar plugins para vscode
	local VSCODE_PLUGINS="chenxsan.vscode-standardjs 
		aslamanver.node-js-dependency-manager 
		formulahendry.code-runner 
		DenisGolovin.dependencies-diagram-generator
		WallabyJs.quokka-vscode
		WallabyJs.wallaby-vscode
		pack.jade-bootstrap
		chenxsan.vscode-standardjs"


}

# Atualiza o npm para ultima versao
ct_npm_update() {
	sudo npm install npm@latest -g
}


ct_npm_install_all_tools() {
	echo "Mocha é um test framework para nodejs - https://www.npmjs.com/package/mocha"
	npm install mocha -g --silent

	echo "O Jest é um agradável framework de testes de JavaScript com foco na simplicidade. - https://jestjs.io/"
	npm install jest -g --silent

	echo "Navegador de última geração e estrutura de teste de automação móvel para Node.js - https://www.npmjs.com/package/webdriverio"
	npm install webdriverio -g --silent

	echo "Editor de package.json - https://github.com/zeke/npe"
	npm install npe -g --silent

	echo "Editor de arquivos.json - https://github.com/maikelvl/dot-json"
	npm install -g dot-json --silent
}

# Cria um novo projeto
# baseado em https://www.youtube.com/watch?v=vV1wQ6GFH0A&list=PL9aKtVrF05DyEwK5kdvzrYXFdpZfj1dsG&index=1cod
ct_nodejs_novo_projeto() {
	echo "Criando repositório git"
	git init &>/dev/null
	echo "Criando gitignore"
	echo "node_modules" > .gitignore
	git add .gitignore
	git commit -m "Adicionado .gitignore para ignorar node_modules"

	echo "Iniciando um projeto node"
	npm init -y &>/dev/null

	read "Qual o nome do projeto?"
	npe author $USER

	git add package.json 
	git commit -m "Inicio do projeto"

	ct_npm_add2Project_standart
	git add *
	git commit -m "adicionando standart"

	ct_npm_add2Project_husk
	git add .huskyrc.json .lintstagedrc.json .huskyrc.json
	git commit -m "adicionando husk"

	ct_npm_add2Project_jest
	git add *
	git commit -m "adicionando jest"

	ct_npm_add2Project_mongodb_jest
	git add *
	git commit -m "adicionando mongodb-jest"

	ct_npm_add2Project_coverage
	git add *
	git commit -m "adicionando converage"
}

ct_npm_add2Project_standart() {
	
	echo "Adicionando modulos"
	echo " - Standard (padrão javascript)"
	npm i standard -D --silent &>/dev/null


	mkdir .vscode
	echo '{
    "recommendations": [
        "standard.vscode-standard"
    ]
}' > .vscode/extensions.json
}

ct_npm_add2Project_husk(){
	echo " - Husky (Rodar script antes de fazer um commit)"
	npm i husky -D --silent &>/dev/null

	echo " - lint-staged (executa os script na area de stage - validar"
	npm i lint-staged -D --silent &>/dev/null
	echo "   - criando arquivo .lintstagedrc.json"
	echo "\"lint-staged\": {
	\"*.js\": [
		\"standard --fix\",
		\"git add\"
		]
	}" > .lintstagedrc.json

	echo "   - criando arquivo .huskyrc.json"
	dot-json .huskyrc.json husky.hooks.pre-commit lint-staged

}

ct_npm_add2Project_jest() {

	echo " - Jest (Framework de test)"
	npm i jest -D --silent &>/dev/null
	

	# https://jestjs.io/docs/en/configuration
	#echo "Gerar o arquivo de configuração do JEST, Responder as 4 perguntas: node y v8 n"
	#jest --init

	echo "   - Criando o arquivo de configuração jest.config.js"
	echo "// For a detailed explanation regarding each configuration property, visit:
// https://jestjs.io/docs/en/configuration.html
module.exports = {
  collectCoverageFrom: ['**/src/**/*.js', '!**/src/main/**'],
  testEnvironment: \"node\",
};
" > jest.config.js

	echo "   - Criando o arquivo de configuração jest.unit.config.js"

	echo "const config = require('./jest.config')
config.testMatch = ['**/*.spec.js']
module.exports = config
" > jest.unit.config.js

	echo "   - Criando o arquivo de configuração jest-integration-config.js"
	echo "const config = require('./jest.config')
config.testMatch = ['**/*.test.js']
module.exports = config
" > jest-integration-config.js

	echo "   - Adicionando script"
	npe scripts.test 'jest --colors --noStackTrace --passWithNoTests --runInBand'
    npe scripts.test:unit 'npm test -- --watch -c jest-unit-config.js'
    npe scripts.test:integration 'npm test -- --watch -c jest-integration-config.js'

	echo "   - Colocando Jest com o standart"
	npe standart.env ["jest"]


}

ct_npm_add2Project_mongodb_jest() {

	echo " - MongoDB"
	npm i mogodb --silent &>/dev/null
	npm i @shelf/jest-mongodb -D --silent &>/dev/null

	echo "   - Adicionando arquivo "
	echo "module.exports = {
  mongodbMemoryServerOptions: {
    instance: {
      dbName: 'jest'
    },
    binary: {
      version: '4.0.3',
      skipMD5: true
    },
    autoStart: false
  }
}
" > jest-mongodb-config.js

	sed -i  "s/module.exports = {/module.exports = {\n  preset: \\'@shelf\/jest-mongodb\\',/g" jest.config.js
}

ct_npm_add2Project_coverage() {
	echo "   - Adicionando scripts - Coverage"
	npm i coveralls -D --silent &>/dev/null
	npe scripts.test:ci 'npm test -- --coverage --silent'
    npe scripts.test:coveralls 'npm run test:ci && coveralls < coverage/lcov.info'

	echo coverage >> .gitignore

	sed -i  "s/module.exports = {/module.exports = {\n  coverageDirectory: \\'coverage\\',/g" jest.config.js
	sed -i  "s/module.exports = {/module.exports = {\n  collectCoverageFrom: [\\'**\/src\/**\/*.js\\',\\'\!**\/src\/main\/**\\'],/g" jest.config.js 

}


ct_npm_listarTodasConfiguracoes() {
	echo_and_run npm config ls -l
}

ct_npm_setarConfiguracoesPadroes() {
	npm config edit
}


## Configuraçoes



### CACHE
ct_npm_cache_clean() {
	echo_and_run npm cache clear
}

### Globals
ct_npm_modules_listGlobals() {
	echo_and_run npm -g ls
}

ct_npm_modules_delete() {
	: ${1?' <module_name>'}
	echo_and_run npm -g rm $1
}







## Outros commandos

# URL encode
ct_node_uriEncode() {
  node -p "encodeURIComponent('${1//\'/\\\'}')"
}