#!/bin/bash

#git clone https://github.com/longjon/caffe.git
#mv caffe caffe-fcn
cd caffe-fcn
#git checkout future
sed 's/atlas/open/' Makefile.config.example > Makefile.config

make -j8
make py

