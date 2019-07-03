# Baixar arquivos antigos: http://www.oracle.com/technetwork/java/javase/archive-139210.html

JDK_HOME="/desenv/jdk/jdk8"
JAVA_HOME=$JAVA_HOME;

jdk8()
{
	JAVA_HOME=/desenv/jdk/jdk8
	JDK_HOME=/desenv/jdk/jdk8
}

jdk7()
{
	JAVA_HOME=/desenv/jdk/jdk7
	JDK_HOME=/desenv/jdk/jdk7
}

jdk6()
{
	JAVA_HOME=/desenv/jdk/jdk6
	JDK_HOME=/desenv/jdk/jdk6
}


jre8()
{
	JAVA_HOME=/home/desenv/jre/jre8
	JDK_HOME=/home/desenv/jre/jre8
}
jre7()
{
	JAVA_HOME=/home/desenv/jre/jre7
	JDK_HOME=/home/desenv/jre/jre7
}


# Lista todas bibliotecas que tem dentro de um arquivo EAR.
# Obs.: necessario instalar apt-get install jar
# Use: libIntoEAR <arquivo.ear>
javaLibsIntoEAR() {
	jar -tvf $1
}

javaShowManifest(){
	local file=$(realpath $1);
	unzip -q -c $file META-INF/MANIFEST.MF
}


javaDecompiler()
{
	java -jar /desenv/java/jd-gui-1.4.0.jar "$1"
}


# Procura bibliotecas JARS que esta esteja no sistema/no computador na pasta contendo EAP
procuraJarsNoSistema() {
	# $1 - arquivo .war
	for i in $(unzip -l "$1" | grep WEB-INF/lib | awk -F"/" '{print $3}')
	do
		echo -e $CRed$i$NC
		locate $i | grep "$i\$" | grep eap;
	done

}

# https://www.logicbig.com/how-to/java-command/jvm-option-list.html
ct_java_PrintFlagsFinal() {
	java -XX:+PrintFlagsFinal -version
}

ct_java_ListProcess() {
	jps -v
}