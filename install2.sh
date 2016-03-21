#!/bin/bash

if [ ! -f install1.done ]
then
echo "install1.sh is not done successfully."
echo "not proceeding"
exit
fi

sudo pip install --upgrade pip
export LDFLAGS=-shared
sudo pip install -r requirements.txt
sudo pip install --upgrade https://github.com/Theano/Theano/archive/master.zip
sudo pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip

cat > $HOME/.theanorc <<FOO
[global]

floatX=float32
device = gpu0
FOO

