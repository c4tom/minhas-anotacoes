# https://www.ibm.com/developerworks/library/j-5things13/
# https://www.sonatype.com/ebooks

#export MVN="/usr/bin/mvn"

[[ -f /usr/bin/mvn ]] || { return ; }

export MVN=mvn

MVN_SKIP_TESTS="-DskipTests=true"
MVN_WTPVERSION="-Dwtpversion=2.0"

alias mvninstall="$MVN install $MVN_SKIP_TESTS"
alias mvnclean="$MVN clean"
alias mvnpackage="$MVN install $MVN_SKIP_TESTS"
alias mvnreset="mvnclean; mvninstall; mvneclipseclean; mvneclipseeclipse; mvnpiceclipse"
alias mvncleanpackage="$MVN clean package $MVN_SKIP_TESTS"
alias mvneclipseeclipse="$MVN eclipse:eclipse $MVN_WTPVERSION"
alias mvnpiceclipse="$MVN picEclipse:corrige"
alias mvneclipseclean="$MVN eclipse:clean; rm -fr target bin"
alias mvnDeploy="$MVN deploy $MVN_SKIP_TESTS"
alias mvnVersion="$MVN -v"

alias mvnDependencyTree="$MVN dependency:tree"
alias mvnDependencyList="$MVN dependency:list"
alias mvnDependencyDuplicate="$MVN dependency:analyze-duplicate"
alias mvnDependencyUnneeded="$MVN dependency:analyze"
alias mvnDependencyClassPathList="$MVN dependency:build-classpath"

alias mvnHelpEffectivePom="$MVN help:effective-pom"
alias mvnHelpEffectiveSettings="$MVN help:effective-settings"
alias mvnHelpEnvironPropertiesList="$MVN help:system"

# Adicionar drive OJDBC14 no repositório do maven (precisa baixar o arquivo: ojdbc14.jar)
# Para saber qual é a versão do pacote ojdbc rode: java -jar ojdbc6.jar
alias mvn-install-ojdbc6="mvn install:install-file -DgroupId=com.oracle -DartifactId=ojdbc6 -Dversion=11.2.0.3.0 -Dpackaging=jar -Dfile=/home/desenv/drivers/ojdbc6.jar";

# instala uma versão do java no repositorio local
# $1 - caminho do arquivo : /caminho/arquivo/ojdbc6.jar
mvnjar_install() {
	local versao=$(java -jar $1 | grep compiled | cut -d" " -f 2)
	local filename=$(basename $1)
	local artifact=`echo ${filename%%.*}`
	echo "Informe o groupId : exemplo: com.oracle"
	read groupId

	if [[ -z $versao ]]
	then
		echo "Informe o valor da versão"
		read versao
	fi

	echo "Linha de comando:"
	local cmd="mvn install:install-file -DgroupId=$groupId -DartifactId=$artifact -Dversion=$versao -Dpackaging=jar -Dfile=$1 -DgeneratePom=true"
	echo $cmd
	echo ""
	echo "Deseja continuar? Para parar pressione CTRL+c ou ENTER para continuar"
	read tmp
	$cmd
}

#
#
#
ct_mvn_jar_install_file(){
	# groupId=$1 artifactId=$2 version=$3 file=$4
	local cmd="mvn install:install-file -DgroupId=$1 -DartifactId=$2 -Dversion=$3 -Dpackaging=jar -Dfile=$4 -DgeneratePom=true"
}

# https://mvnrepository.com/artifact/org.apache.maven.plugins/maven-compiler-plugin

ct_mvn_dependency_resolve_plugins(){
	mvn dependency:resolve
	mvn dependency:resolve-plugins
}
ct_mvn_display_dependency_updates()
{
	echo "Exibe as atualizações existentes para as dependências do projeto."
	mvn versions:display-dependency-updates
}
ct_mvn_display_plugins_updates() {
	echo "Exibe as atualizações existentes para os plugins configurados no projeto."
	mvn versions:display-plugin-updates
}
