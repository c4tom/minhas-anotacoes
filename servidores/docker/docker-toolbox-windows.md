# Docker Toolbox - Windows

Problemas para rodar no windows - elasticsearch

https://github.com/boot2docker/boot2docker/issues/1216

```
docker-machine ssh default
sysctl -w vm.max_map_count=262144

sysctl -w fs.file-max=65536

```