#https://github.com/bitnami/minideb

# The minideb container image is the base image for many Bitnami-maintained language runtimes 
# including php, nodejs, ruby and infrastructure components including mariadb, redis, nginx and mongodb.

FROM bitnami/minideb:stretch

RUN apt-get update
RUN apt install net-tools
RUN install_packages ssh inetutils-ping

EXPOSE 22

CMD ["bash"]