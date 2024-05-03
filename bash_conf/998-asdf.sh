
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
    local plugins=$(asdf plugin list all | awk '{print $1}')

    if [[ -z "$plugins" ]]; then
        echo "Nenhum plugin disponível para instalação."
        return 1
    fi

    echo "Plugins disponíveis para instalação:"
    select plugin in $plugins; do
        if [[ -n "$plugin" ]]; then
            echo "Instalando o plugin $plugin..."
            echo_and_run asdf plugin add $plugin
            break
        else
            echo "Opção inválida. Escolha novamente:"
        fi
    done

    echo "use ct_asdf_install_version para instalar versões de um plugin"
}


ct_asdf_dashboard() {
    echo_and_run asdf info
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

    local versions=($(echo "$all_versions"))
    
    echo "Versões disponíveis para $tool:"
    echo "${versions[@]}"
    
    if [[ ${#versions[@]} -eq 0 ]]; then
        echo "Nenhuma versão disponível para $tool."
        return 1
    fi
    
    echo "Qual versão de $tool você deseja instalar? Escolha o número correspondente:"
    select version in "${versions[@]}"; do
        if [[ -n "$version" ]]; then
            break
        else
            echo "Opção inválida. Escolha novamente:"
        fi
    done
    
    echo "Instalando $tool $version..."
    echo_and_run asdf install $tool $version
    echo_and_run asdf global $tool $version
    echo_and_run asdf local $tool $version

    return 0
}
