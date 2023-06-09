#!/bin/bash



ct_zt_obter_lista_de_ip() {
    # Lê as variáveis de ambiente ZTTK (token) e ZTNET (network)
    local token=$ZTTK
    local network=$ZTNET

    # Verifica se as variáveis de ambiente estão definidas
    if [ -z "$token" ] || [ -z "$network" ]; then
        read -p "Digite o token de acesso à API do ZeroTier: " token
        read -p "Digite o ID da rede do ZeroTier: " network
    fi

    # Faz a solicitação GET para a API do ZeroTier
    api_url="https://my.zerotier.com/api/network/$network/member"
    response=$(curl -s -H "Authorization: Bearer $token" "$api_url")

    # Verifica se a solicitação foi bem-sucedida
    if [ $? -ne 0 ]; then
        echo "Erro ao fazer a solicitação à API do ZeroTier."
        exit 1
    fi

    # Analisa a resposta JSON e exibe os IPs, status online e nome dos membros
    echo "IP               | Online | Nome"
    echo "-----------------|--------|------"
    jq -r '.[] | [.name, .config.ipAssignments[0], (.lastOnline | strftime("%d/%m/%Y %H:%M:%S"))] | @tsv' <<< "$response"


    # Solicita confirmação do usuário
    read -p "Deseja continuar e adicionar/atualizar as entradas no arquivo /etc/hosts? (s/N) " confirm

    if [[ "$confirm" =~ ^[Ss]$ ]]; then
        # Formatação e atualização do arquivo /etc/hosts
        hosts_file="/etc/hosts"

        echo "Digite a senha do sudo"
        jq -r '.[] | [.name, (.config.ipAssignments[]), .lastOnline] | @tsv' <<< "$response" |
        while IFS=$'\t' read -r name ip lastonline; do
            # Verifica se a entrada já existe no arquivo hosts
            if grep -q -E "^\s*$ip\s+" "$hosts_file"; then
                # Atualiza a entrada existente com o nome
                sudo sed -i -E "s/^\s*$ip\s+.*/$ip\t$name/g" "$hosts_file"
            else
                # Adiciona uma nova entrada no arquivo hosts
                sudo echo "$ip    $name" | sudo tee -a "$hosts_file" >/dev/null
            fi
        done

    else
        echo "Operação cancelada pelo usuário."
    fi

}

