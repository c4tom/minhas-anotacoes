# Docker

* [Boas práticas para criar dockerfiles](https://docs.docker.com/engine/userguide/eng-image/dockerfile_best-practices/)
  - [Multistage](https://www.digitalocean.com/community/tutorials/how-to-optimize-docker-images-for-production)
  - [BuildKit](https://www.docker.com/blog/advanced-dockerfiles-faster-builds-and-smaller-images-using-buildkit-and-multistage-builds/)
* [Explorar imagens](https://hub.docker.com/explore/)

## Instalação

curl -sSL [https://get.docker.com/](https://get.docker.com/) \| sudo bash

## Executar sem SUDO

Para executar o comando docker sem usar o `sudo docker` siga os passos:

[https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo](https://askubuntu.com/questions/477551/how-can-i-use-docker-without-sudo)

```
sudo groupadd docker
sudo gpasswd -a $USER docker

ou

sudo usermod -aG docker $USER
```

## Gerenciadores Dockers

[Alternativas](http://alternativeto.net/software/portainer/)

* [Docker Toolbox](https://www.docker.com/products/docker-toolbox) Win7,8,10 e MacOS
* [https://portainer.io/](https://portainer.io/) 
  `sudo docker run -d -p 9000:9000 --restart always --name portainer -v /opt/portainer-data:/data -v /var/run/docker.sock:/var/run/docker.sock portainer/portainer --no-auth`
  * [http://portainer.readthedocs.io/en/stable/configuration.html?highlight=--no-auth](http://portainer.readthedocs.io/en/stable/configuration.html?highlight=--no-auth)
* [Kubernetes](https://kubernetes.io/)
* [DataPulley](https://github.com/DataPulley/datapulley) \(identico ao kubernetics\)
* [Rancher](http://rancher.com/)

## - [Imagens](docker-images.md)

## - [Problemas](problemas.md)

## - [Dicas](dicas.md)
