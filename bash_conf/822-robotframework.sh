# https://robotframework.org/?tab=1#getting-started


[[ -f /usr/bin/python3.9 ]] || { 
    ct_robotframework_install() {
        sudo apt install python3.9 python3-pip
        
        # adicionando python 3.9 como uma opção alternativa
        sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.9 1

        sudo update-alternatives --config python

        pip install robotframework

        $HOME/.local/bin/robot --version

        echo "Reabrir o terminal..."
    }    
    return ; 
}

export PATH=$PATH:$HOME/.local/bin