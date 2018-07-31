# Comandos



## Listar Containers
```bash
docker ps -a                        # todos containers
docker ps -a -f status=running      # somente o que estão em execução
```

## run / Subir um docker
```bash
docker run -d --name <nome> <nome-da-imagem> # ex.: docker run -d --name nome-do-container alpine
```

## Remover Container/images
```bash
docker rmi -f <nome-da-imagem>      # use 'docker ps -a' para listar as imagens
docker rm <id-container>            # use 'docker ps -a' para listar os containers
```

## Atualizar uma imagem
```bash
docker service update --image <imagem> <nome>

ex.:
docker service update --image <portainer/portainer:latest> <portainer>
```

## Abrir Bash em um Container
```bash
docker exec -it <container-ID> bash    # use 'docker ps -a' para listar os containers
# ou
docker exec -it <image-name> sh
```

## Mostrar memória total de cada container
```
for line in `docker ps | awk '{print $1}' | grep -v CONTAINER`; do docker ps | grep $line | awk '{printf $NF" "}' && echo $(( `cat /sys/fs/cgroup/memory/docker/$line*/memory.usage_in_bytes` / 1024 / 1024 ))MB ; done
``` 

## Armazenamento Persistente
```bash 
docker run -d --name mysql -e ...  -v /var/local/mysql:/var/lib/mysql

# listar a pasta no seu host
ls -l /var/local/mysql
```

## Start / Stop / Restart / Statics / Log / Pause / Unpause
```bash
docker <start|stop|restart|stats|log|pause|unpause> <imagem> # Ex.: docker start alpine
```

## BUILD
https://www.digitalocean.com/community/tutorials/docker-explained-using-dockerfiles-to-automate-building-of-images

```bash
docker build -t <nome-da-tag> - < Dockerfile # Linux
# ou
docker build -t <nome-da-tag> .    # desde que o Dockerfile esteja na pasta atual

# Windows PowerShell
Get-Content Dockerfile | docker build -

docker run -name=<name-instance> -i -t <nome-image>

# via URL
docker build github.com/creack/docker-firefox
```


## Volume Data
### Criar
docker volume create --name wordpress_data
### Listar
docker volume ls
### Run (Persisting your application)
docker run ... --volume wordpress_data:/bitnami