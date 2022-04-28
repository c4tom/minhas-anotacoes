
[[ ! -f $(type -P asdf) ]] || { 
    ct_asdf_install() {
        # install, https://youtu.be/epiyExCyb2s?t=2594

        echo "Baixando via git"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.10.0

        echo "Para funcionar o asdf"
        echo ". $HOME/.asdf/asdf.sh" >> ~/.bashrc

        echo "Autocomplete do asdf"
        echo ". $HOME/.asdf/completions/asdf.bash" >> ~/.bashrc

        sudo apt-get install dirmngr gpg curl gawk
        
    }
    return; 
}

ct_asdf_addPlugin_nodejs() {
    echo_and_run asdf plugin add nodejs https://github.com/asdf-vm/asdf-nodejs.git
    echo_and_run asdf install nodejs latest
    echo_and_run asdf global nodejs latest
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