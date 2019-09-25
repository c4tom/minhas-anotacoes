# Baixar arquivos antigos: http://www.oracle.com/technetwork/java/javase/archive-139210.html
export CXF_HOME=/desenv/java/apache-cxf-3.3.3
export JAXWS_HOME=/desenv/java/jaxws-ri

JDK_HOME="/desenv/java/jdk8"
JAVA_HOME=$JDK_HOME

jdk12() {
	JAVA_HOME=/desenv/java/jdk12
	JDK_HOME=$JAVA_HOME
	export PATH=$PATH:$JDK_HOME/bin
}

jdk8() {
	JAVA_HOME=/desenv/java/jdk8
	JDK_HOME=$JAVA_HOME
	export PATH=$PATH:$JDK_HOME/bin
}

jre8() {
	JAVA_HOME=/desenv/java/jdk8/jre
	JDK_HOME=/desenv/java/jdk8
}

# Lista todas bibliotecas que tem dentro de um arquivo EAR.
# Obs.: necessario instalar apt-get install jar
# Use: libIntoEAR <arquivo.ear>
javaLibsIntoEAR() {
	jar -tvf $1
}

javaShowManifest() {
	local file=$(realpath $1)
	unzip -q -c $file META-INF/MANIFEST.MF
}

# http://java-decompiler.github.io/
javaDecompiler() {
	java -jar /desenv/java/decomp/jd-gui-1.6.3.jar "$1"
}

# Procura bibliotecas JARS que esta esteja no sistema/no computador na pasta contendo EAP
procuraJarsNoSistema() {
	# $1 - arquivo .war
	for i in $(unzip -l "$1" | grep WEB-INF/lib | awk -F"/" '{print $3}'); do
		echo -e $CRed$i$NC
		locate $i | grep "$i\$" | grep eap
	done

}

# https://www.logicbig.com/how-to/java-command/jvm-option-list.html
ct_java_PrintFlagsFinal() {
	java -XX:+PrintFlagsFinal -version
}

ct_java_ListProcess() {
	jps -v
}

export PATH=$PATH:$CXF_HOME/bin:$JAXWS_HOME/bin
