
[[ -f "${HOME}/.asdf/bin/asdf" ]] || { 
    ct_asdf_install() {
        # install, https://youtu.be/epiyExCyb2s?t=2594

        echo "Baixando via git"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0

        echo "Para funcionar o asdf"
        echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc

        echo "Autocomplete do asdf"
        echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc

        echo "Criando Link simbolico em /desenv/asdf"
        mkdir -p /desenv/asdf/{installs,downloads,plugins}; ln -sf /desenv/asdf/{installs,downloads,plugins} .

        sudo apt-get install dirmngr gpg curl gawk
        
    }
    return; 
}

ct_asdf_addPlugin_nodejs() {
    local VERSION=${1:-"latest"};
    echo_and_run asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    echo_and_run asdf install nodejs $VERSION
    echo_and_run asdf global nodejs $VERSION
}

ct_asdf_nodejs_install_version() {
    asdf list all nodejs
    local version=""
    echo "Qual versão? "
    echo ""
    read version
    
    echo_and_run asdf install nodejs $version
    echo_and_run asdf global nodejs $version
    echo_and_run asdf local nodejs $version
    node -v
}

ct_asdf_legacy_versions() {
    echo "legacy_version_file = yes" > ~/.asdfrc
}


ct_asdf_addPlugin_python() {
    echo_and_run asdf plugin add python
}


ct_asdf_addPlugin_dotnetcore() {
    echo_and_run asdf plugin-add dotnet-core https://github.com/emersonsoares/asdf-dotnet-core.git
    echo_and_run asdf install dotnet-core latest

}

ct_asdf_addPlugin_java() {
    echo_and_run asdf plugin-add java https://github.com/halcyon/asdf-java.git
    local version=""
    echo "Qual versão? "
    echo ""
    read version
    asdf list-all java | grep ^openjdk
    echo ""
    echo_and_run asdf install java $version
}
