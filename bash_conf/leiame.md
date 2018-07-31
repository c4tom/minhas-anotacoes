Scripts úteis para uso via shell bash

Para colocar em funcionamento:
- coloque esta pasta no seu /home/<seu-usuario>/
- editar o arquivo ~/.bashrc e adicione no final do arquivo
```bash
for i in ~/bash_conf/*.sh; do . $i; done
```

ao abrir um terminal bash, cada arquivo *.sh que esta dentro da pasa **bash_conf** será executado