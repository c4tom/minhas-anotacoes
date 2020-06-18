# Baixar arquivos antigos: http://www.oracle.com/technetwork/java/javase/archive-139210.html
export CXF_HOME=/desenv/java/apache-cxf-3.3.3
export JAXWS_HOME=/desenv/java/jaxws-ri

JDK_HOME="/desenv/java/jdk8"
JAVA_HOME=$JDK_HOME


ct_java_switch_jdk12() {
	JAVA_HOME=/desenv/java/jdk12
	JDK_HOME=$JAVA_HOME
	export PATH=$PATH_ORIGINAL:$JDK_HOME/bin
}

ct_java_switch_jdk8() {
	JAVA_HOME=/desenv/java/jdk8
	JDK_HOME=$JAVA_HOME
	export PATH=$PATH_ORIGINAL:$JDK_HOME/bin
}


# Lista todas bibliotecas que tem dentro de um arquivo EAR.
# Obs.: necessario instalar apt-get install jar
# Use: libIntoEAR <arquivo.ear>
ct_java_libsIntoEAR() {
	jar -tvf $1
}

ct_java_showManifest() {
	local file=$(realpath $1)
	unzip -q -c $file META-INF/MANIFEST.MF
}

# http://java-decompiler.github.io/
ct_java_decompiler() {
	java -jar /desenv/java/decomp/jd-gui-1.6.3.jar "$1"
}

# Procura bibliotecas JARS que esta esteja no sistema/no computador na pasta contendo EAP
ct_java_procuraJarsNoSistema() {
	# $1 - arquivo .war
	for i in $(unzip -l "$1" | grep WEB-INF/lib | awk -F"/" '{print $3}'); do
		echo -e $CRed$i$NC
		locate $i | grep "$i\$" | grep eap
	done

}

# https://www.logicbig.com/how-to/java-command/jvm-option-list.html
ct_java_printFlagsFinal() {
	java -XX:+PrintFlagsFinal -version
}

ct_java_listProcess() {
	jps -v
}

export PATH=$PATH:$CXF_HOME/bin:$JAXWS_HOME/bin


ct_java_removeComments() {
	sed -i '/\/\*/{:loop;/\/\*.*\*\//{d;b out};N;b loop};:out' "$1"
}