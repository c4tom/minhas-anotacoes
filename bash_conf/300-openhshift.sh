# https://manage.openshift.com/account/index Testar Online Gratis

# http://rafabene.com/2016/01/09/docker-images-openshift-network/
# https://github.com/rafabene/devops-demo

# Cliente OpenShift
# Baixe em https://github.com/openshift/origin/releases ou https://www.openshift.org/download.html
# Referencia https://docs.openshift.com/container-platform/3.3/cli_reference/basic_cli_operations.html

## Utilizado a versao
## https://github.com/openshift/origin/releases/download/v3.9.0/openshift-origin-client-tools-v3.9.0-191fece-linux-64bit.tar.gz

# Pegar o Token
# Acesse pelo navegador e pegue o token https://<server>:8443/console/command-line então execute o comando abaixo:
# oc login https://<server>:8443 --token=<TOKEN>


#Observação: Profile é gravado em ~/.kube/config

[[ -f /usr/bin/oc ]] || { return ; }
OC="/usr/bin/oc"


# $1 = projeto
ct_ocLogin() {
	# Fazer login no openshift
	if [  `ct_ocIsLogged` = "0" ]
		then
			echoColor "Logando em: $OC_SERVER_ADDR como: $LOGNAME"
			$OC login --username=$LOGNAME $OC_SERVER_ADDR
			$OC project $1
		else
			echo ">>> Já esta logado";
	fi
}


ct_extractCookieFirefox() {
	cd /tmp/
	wget https://gist.githubusercontent.com/hackerb9/d382e09683a52dcac492ebcdaf1b79af/raw/fced8cae8fd1f9573646336dcc8093a10e373e03/extract_cookies.sh
	sh extract_cookies.sh  > cookies.txt
	
}

# Login via Token, get it from
# https://<URL-openshift-server>/console/command-line
ct_ocLoginToken() {
	$OC login $OC_SERVER_ADDR --token=$OC_TOKEN
	$OC project $1
}


############### ADMIN ##################

# $1 = Registro do usuario com C
# $2 = Nome do projeto
ct_ocAddRole () { 
	local REGISTRO=$1
	local PROJETO=$2
	$OC project $PROJETO; $OC policy add-role-to-user admin $REGISTRO -n $PROJETO
}

# Apaga um usuario do projeto
# $1 chave/registro do usuário
# $2 nome do projeto
ct_ocDelRole() { 
	local REGISTRO=$1
	local PROJETO=$2
	$OC project $PROJETO; $OC policy remove-role-from-user admin $REGISTRO -n $PROJETO
}

# Lista as permissoes de um determinado projeto
# $1 = Nome do projeto
ct_ocListRole() {
	$OC describe policyBindings :default -n $1
}

# $1 = Nome do projeto
ct_ocDescribeProject() {
	local PROJETO=$1
	ct_ocListRole $PROJETO
}



######### PHP ###########


# abre ssh no pod do PHP
ct_ocSSHPHP() {
	$OC rsh `_ocGetRunningPODPHP`
}

# Mapeia uma porta do POD para Host
ct_ocFORWARDMYSQL() {
	$OC port-forward `_ocGetRunningPOD` 3307:3306
}


_ocGetRunningPODPHP() {
	echo `$OC get pod | grep php | grep Running | awk '{print $1}'`
}

_ocGetRunningPOD() {
	echo `$OC get pod --sort-by={metadata.creationTimestamp} | grep -v "deploy" | grep Running | awk '{print $1}' | head -n 1 	`
}

# abre ssh no pod do PHP
ct_ocSSH() {
	$OC rsh `_ocGetRunningPOD`
}

# executa o bash no POD
ct_ocExec() {
	$OC exec `_ocGetRunningPOD` -- $1
}

ct_ocCPLocal2Remoto(){
	$OC cp $1 `_ocGetRunningPOD`:$2
}

# Abre a porta 8787 para fazer debug com um POD
# $1 nome do projeto (opcional)
# https://blog.openshift.com/debugging-java-applications-on-openshift-kubernetes/
# Adicione um novo "Remote Java Aplication" e setar a porta 8787
ct_ocDebug() {
	echo 'https://blog.openshift.com/debugging-java-applications-on-openshift-kubernetes/'
	echo 'Adicione um novo "Remote Java Aplication" e setar a porta 8787'
	
	local pod=`_ocGetRunningPOD`
	$OC set env dc/$1 DEBUG=true
	echo "$OC POD: $pod"
	$OC port-forward $pod 8787:8787 
	
}

# $1 = container name (ou nome do projeto, ex.: doahml, atihml, etc)
ct_ocServerLog()
{
		$OC logs -f dc/$1
}


ct_ocRSYNCPHPSEND() {
	$OC rsync $1 `_ocGetRunningPODPHP`:$2 $3 $4 $5
}

ct_ocRSYNCPHPGET() {
	$OC rsync `_ocGetRunningPODPHP`:$1 $2 $3 $4 $5
}

# faz um rsync do host para guest (pod)
# $1 pasta local (host)
# $2 pasta guest (pod)
ct_ocRSYNC() {
	local PASTA_LOCAL=$1
	local PASTA_REMOTO=$2
	$OC rsync $PASTA_LOCAL `_ocGetRunningPOD`:$PASTA_REMOTO
}


ct_ocRSYNC_REMOTO2LOCAL() {
	local PASTA_LOCAL=$1
	local PASTA_REMOTO=$2
	$OC rsync `_ocGetRunningPOD`:$PASTA_REMOTO $PASTA_LOCAL
}

# Verifica se esta logado no servidor do openshift
ct_ocIsLogged() {
	result=`$OC status 2>&1 | grep error`
	if [ -n "$result" ]
		then
			echo 0
		else
			echo 1
	fi
}

# argumentos usados para montar pacote no maven para openshift
ct_mvn_package_openshift()
{
	mvn -e -Popenshift -DskipTests -Dcom.redhat.xpaas.repo.redhatga package -Djava.net.preferIPv4Stack=true 
}


ct_ocClusterUp(){
	 sudo oc cluster up --public-hostname='127.0.0.1' \
	 	--host-data-dir=$HOME/.oc/profiles/$PROFILE/data \
		--host-config-dir=$HOME/.oc/profiles/$PROFILE/config \
		--use-existing-config
		--insecure-registry 172.30.0.0/16
}


ct_ocCompletionInstall() {
	sudo $OC completion bash > /tmp/bash_completion.sh
  	source /tmp/bash_completion.sh
}



# Copia o template para a pasta local
# GITHOSTPRD deve ser setado no .bashrc
ct_openshiftMakeSkelByTemplate(){
	local TEMPLATEDIR="/tmp/template_eap_6.4"
	rm -fr $TEMPLATEDIR;
	cd /tmp
	git clone --dissociate --depth 1 git@$GITHOSTPRD:template/template_eap_6.4.git
	rm -fr $TEMPLATEDIR/.git

	cp -arv $TEMPLATEDIR/* .
	cp -av $TEMPLATEDIR/.gitignore .
}
