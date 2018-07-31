
**1. Resolvendo nomes dentro do container**

Se tiver problemas para resolver nomes dentro de um container:
 - verificar dentro do container o arquivo **/etc/resolv.conf**
 - Se estiver rodando docker no linux, editar o arquivo **/etc/default/docker** e alterar `DOCKER_OPTS="--dns 8.8.8.8"`
 - [ver referência ](https://docs.docker.com/engine/userguide/networking/default_network/configure-dns/)


 **2. Sem internet dentro do container**
 No linux, se ao subir um container, e dentro dele não funcionar internet, tente isso:

`sysctl -w net.ipv4.ip_forward=1`