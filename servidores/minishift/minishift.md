#Minishift

## Instalação

### Linux
Baixar a ultima versão

`wget https://github.com/minishift/minishift/releases/download/v1.20.0/minishift-1.20.0-linux-amd64.tgz`


**Inicialização do servidor**

[Inicio Rápido](https://docs.openshift.org/latest/minishift/getting-started/quickstart.html)
[Setting Up the Virtualization Environment](https://docs.openshift.org/latest/minishift/getting-started/setting-up-virtualization-environment.html#setting-up-virtualbox-driver)

`minishift config set vm-driver virtualbox`

```bash
minishift start


-- Starting profile 'minishift'
-- Check if deprecated options are used ... OK
-- Checking if https://github.com is reachable ... OK
-- Checking if requested OpenShift version 'v3.9.0' is valid ... OK
-- Checking if requested OpenShift version 'v3.9.0' is supported ... OK
-- Checking if requested hypervisor 'virtualbox' is supported on this platform ... OK
-- Checking if VirtualBox is installed ... OK
-- Checking the ISO URL ... OK
-- Checking if provided oc flags are supported ... OK
-- Starting local OpenShift cluster using 'virtualbox' hypervisor ...
-- Minishift VM will be configured with ...
   Memory:    2 GB
   vCPUs :    2
   Disk size: 20 GB
-- Starting Minishift VM ............................ OK
-- Checking for IP address ... OK
-- Checking for nameservers ... OK
-- Checking if external host is reachable from the Minishift VM ... 
   Pinging 8.8.8.8 ... OK
-- Checking HTTP connectivity from the VM ... 
   Retrieving http://minishift.io/index.html ... OK
-- Checking if persistent storage volume is mounted ... OK
-- Checking available disk space ... 1% used OK
   Importing 'openshift/origin:v3.9.0'  CACHE MISS
   Importing 'openshift/origin-docker-registry:v3.9.0'  CACHE MISS
   Importing 'openshift/origin-haproxy-router:v3.9.0'  CACHE MISS
-- OpenShift cluster will be configured with ...
   Version: v3.9.0
-- Copying oc binary from the OpenShift container image to VM ............................................................ OK
-- Starting OpenShift cluster ............................................................................
Using nsenter mounter for OpenShift volumes
Using public hostname IP 192.168.99.101 as the host IP
Using 192.168.99.101 as the server IP
Starting OpenShift using openshift/origin:v3.9.0 ...
OpenShift server started.

The server is accessible via web console at:
    https://192.168.99.101:8443

You are logged in as:
    User:     developer
    Password: <any value>

To login as administrator:
    oc login -u system:admin


-- Exporting of OpenShift images is occuring in background process with pid 20079.

```

`minishift console` 
ao abrir o console, pode logar com qualquer usuario e senha, não tem um especifico

## Aprendendo...

https://learn.openshift.com/

