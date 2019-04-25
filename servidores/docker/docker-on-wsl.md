
Install Docker On WSL

```sh
sudo apt-get update

sudo apt-get install apt-transport-https ca-certificates curl gnupg2 software-properties-common


curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo apt-key add -
sudo add-apt-repository "deb [arch=amd64] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable"

sudo apt-get update


sudo apt-get install docker-ce=17.09.0~ce-0~ubuntu

apt list -a docker-ce

sleep 10
sudo usermod -aG docker $USER
```