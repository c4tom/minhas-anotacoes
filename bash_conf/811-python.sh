#!/bin/bash

ct_python3_install_pip(){
    sudo apt install python3-pip
}


ct_python_configure_default() {
    sudo update-alternatives --install /usr/bin/python python /usr/bin/python3.10
}