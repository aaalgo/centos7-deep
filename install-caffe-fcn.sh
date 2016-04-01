#!/bin/bash

git clone https://github.com/longjon/caffe.git
mv caffe caffe-fcn
cd caffe-fcn
git checkout future
sed 's/atlas/open/' Makefile.config.example > Makefile.config

make -j8
make py
sudo cp -r build/lib/* /usr/lib
sudo cp -r include/caffe /usr/include/
sudo mkdir -p /usr/include/caffe/proto
sudo cp  build/src/caffe/proto/*.h /usr/include/caffe/proto
sudo cp -r python/caffe /usr/lib/python2.7/site-packages/

