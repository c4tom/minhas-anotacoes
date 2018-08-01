
[[ -f /projetos/git-st/lib/starteam110.jar ]] || { return ; }
# Requisitos
# ant git e debian ou qualquer que instale .deb

install-git-st() {
	mkdir -p /projetos
	cd /projetos

	git clone https://github.com/brijnandan/git-st.git
	cd git-st

	ant

	## instalacao no debian, procure o pacote dentro da pasta distribs/<data-hoje>/deb/
	hoje=$(date +"%d.%m.%y")
	dpkg -i distribs/$hoje/deb/git-st_1.0.0_amd64.deb
}

export STARTEAM_JAVA_API=/projetos/git-st/lib/starteam110.jar

git-starteam() {

	# Crie um arquivo smbfile que contem conteudo:
	# password=minhasenha

	# LOGNAME é a chave de rede

	
	local projeto="$1"
	local PASSWORD=$(grep "^password" ~/.smbfile  | cut -d'=' -f2-)
	git clone "starteam://$LOGNAME:$PASSWORD@servgcs:49211/$projeto"
}


PATH_GITST="/path/to/git-st"
GIT_ST=$PATH_GITST/git-st

git-starteam_init() {
	PROJECT=$1
	VIEW=$2
	PASTA_DESTINO=$3

	$GIT_ST init -h servgcs -p 49211 -P $PROJECT -V $VIEW -d $PASTA_DESTINO
}

git-starteam_pull() {
	$GIT_ST pull
}