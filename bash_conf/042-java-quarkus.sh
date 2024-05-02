# https://quarkus.io/guides/maven-tooling


ct_quarkus_cli_install() {
    # é preciso do java 17ty

    curl -Ls https://sh.jbang.dev | bash -s - trust add https://repo1.maven.org/maven2/io/quarkus/quarkus-cli/
    curl -Ls https://sh.jbang.dev | bash -s - app install --fresh --force quarkus@quarkusio

    echo "Edite o arquivo: /home/$HOME/.jbang/bin/quarkus e adicione: export JAVA_HOME=/caminho/do/jdk-17 caso você nao tenha o como padrãoqua"
}
