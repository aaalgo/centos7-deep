#!/bin/bash

if [ ! -f install1.done ]
then
echo "install1.sh is not done successfully."
echo "not proceeding"
exit
fi

if [ `which nvcc` != '/usr/local/cuda/bin/nvcc' ]
then
echo "Cuda not correctly installed."
echo "something's wrong"
exit
fi

# detect and install NVidia driver
nvidia-smi
if [ $? != 0 ]
then
	echo nvidia driver not installed
	echo Download and install driver here http://www.nvidia.com/Download/index.aspx
	exit
fi

sudo pip install --upgrade pip
export LDFLAGS=-shared
sudo pip install -r requirements.txt
sudo pip install --upgrade https://github.com/Theano/Theano/archive/master.zip
sudo pip install --upgrade https://github.com/Lasagne/Lasagne/archive/master.zip
sudo pip install --upgrade https://storage.googleapis.com/tensorflow/linux/gpu/tensorflow-0.7.1-cp27-none-linux_x86_64.whl

cat > $HOME/.theanorc <<FOO
[global]

floatX=float32
device = gpu0
FOO

