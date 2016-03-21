#!/bin/bash

git clone https://github.com/dmlc/mxnet.git
cd mxnet
git submodule init
git submodule update
echo "CMAKE_SHARED_LINKER_FLAGS:STRING='-L/usr/local/cuda/lib64'" > CMakeCache.txt
cmake .
make -j8
if [ -f liblibmxnet.so ]
then
mkdir -p lib
mv liblibmxnet.so lib/libmxnet.so
fi
if [ ! -f lib/libmxnet.so ]
then
echo Failed to build mxnet.
fi
cd python
sudo python setup.py install

