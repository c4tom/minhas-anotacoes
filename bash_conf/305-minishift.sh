MINISHIFTBIN="/desenv/minishift/minishift"
# Continua rodando o script, se existir o arquivo $MINISHIFTBIN
[[ -f $MINISHIFTBIN ]] || { return ; }

export MINISHIFTBIN;

# Minishift
PATH=$PATH:/desenv/minishift

ct_minishiftInstallCompletion() {
   sudo $MINISHIFTBIN completion bash > /tmp/minishift_completion
   sudo cp /tmp/minishift_completion /etc/bash_completion.d/minishift
}

