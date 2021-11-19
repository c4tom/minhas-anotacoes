#!/bin/sh

BASH_SCRIPTS=$(pwd)/bash_conf

echo "
for i in $BASH_SCRIPTS/*.sh
do
	source \$i
done

" >> ~/.bashrc

