#!/bin/bash

[[ -f "${HOME}/.asdf/bin/asdf" ]] || { 
    ct_asdf_install() {
        # install, https://youtu.be/epiyExCyb2s?t=2594

        echo "Baixando via git"
        git clone https://github.com/asdf-vm/asdf.git ~/.asdf --branch v0.13.1

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

ct_asdf_convert_dos2unix() {
    for i in $(find . -not -path "./.git/*" -type f)
    do 
        MIME=$(file --mime-type -b "$i");  
        if test $MIME = "text/x-shellscript"
            then 
                echo $i; 
                dos2unix "$i"; 
        fi
        dos2unix lib/asdf.sh
    done

    for i in $(find . -name "*.bash")
    do 
        dos2unix "$i"; 
    done
}

ct_asdf_legacy_versions() {
    echo "legacy_version_file = yes" > ~/.asdfrc
}

# Função para listar os plugins disponíveis e permitir que o usuário escolha um para instalar
ct_asdf_install_plugin_menu() {
    local filtro=$1
    local plugins=""

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

ct_asdf_addPlugin_python() {
    echo_and_run asdf plugin add python
}

ct_asdf_install_version() {
    local current_tool="$(asdf current 2>&1)"
    
    local tools=($(echo "$current_tool" | awk '{print $1}'))
    
    if [[ ${#tools[@]} -eq 0 ]]; then
        echo "Nenhuma ferramenta disponível para instalação."
        return 1
    fi
    
    echo "Qual ferramenta você deseja instalar? Escolha o número correspondente:"
    select tool in "${tools[@]}"; do
        if [[ -n "$tool" ]]; then
            break
        else
            echo "Opção inválida. Escolha novamente:"
        fi
    done
    
    # Verifica se a ferramenta é Java e ajusta o comando para listar apenas OpenJDK
    local all_versions=""
    if [[ "$tool" == "java" ]]; then
        all_versions=$(asdf list-all $tool | grep "openjdk")
    else
        all_versions=$(asdf list-all $tool)
    fi
    
    echo "Versões disponíveis para $tool:"
    echo "$all_versions"
    
    local version=""
    echo "Qual versão você deseja instalar? "
    echo ""
    read version
    
    echo_and_run asdf install $tool $version
    echo_and_run asdf global $tool $version
    echo_and_run asdf local $tool $version
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
ct_asdf_dashboard() {
    asdf current
}