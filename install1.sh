#!/bin/bash

CUDA='http://developer.download.nvidia.com/compute/cuda/repos/rhel7/x86_64/cuda-repo-rhel7-7.5-18.x86_64.rpm'
DEVTOOL='https://www.softwarecollections.org/repos/rhscl/devtoolset-3/epel-7-x86_64/noarch/rhscl-devtoolset-3-epel-7-x86_64-1-2.noarch.rpm'

CUDNN='cudnn-7.0-linux-x64-v3.0-prod.tgz'

for U in $CUDA $DEVTOOL
do
  BN=`basename "$U"`
  if [ ! -f $BN ]
  then
        echo "Downloading $BN ..."
	wget --quiet "$U" -O $BN
	if [ ! -f $BN ]
	then
		echo "Failed to download $BN"
		exit
	fi
  fi
done

if [ ! -f $CUDNN ]
then
  echo "cuDNN not found"
  echo "Register and download the following file from https://developer.nvidia.com/cudnn"
  echo "$CUDNN to the current directory"
  exit
fi

sudo rpm -ivh `basename $CUDA` `basename $DEVTOOL`
sudo yum clean all
sudo yum install -y epel-release
sudo yum groupinstall -y 'Development Tools'
# important devtools
sudo yum install -y devtoolset-3-binutils devtoolset-3-elfutils devtoolset-3-gdb devtoolset-3-gcc devtoolset-3-memstomp devtoolset-3-strace devtoolset-3-valgrind devtoolset-3-dyninst devtoolset-3-gcc-c++ devtoolset-3-libstdc++-devel devtoolset-3-ltrace devtoolset-3-perftools devtoolset-3-gcc-gfortran
# install cuda
sudo yum install -y cuda
F=`readlink -e $CUDNN`
echo "Installing CUDNN..."
pushd /usr/local
sudo tar zxf $F
popd
# python
sudo yum install -y python-devel python-pip
sudo yum install -y opencv-devel opencv-python openblas-devel boost-devel libpng-devel libjpeg-turbo-devel freetype-devel
sudo yum install -y hdf5-devel libyaml-devel gflags-devel protobuf-devel glog-devel lmdb-devel leveldb-devel snappy-devel atlas-devel

sudo sh -c 'echo /usr/local/cuda/lib64 > /etc/ld.so.conf.d/cuda.conf'
sudo ldconfig
sudo sh -c 'echo export PATH=/opt/rh/devtoolset-3/root/usr/bin:/usr/local/cuda/bin:$PATH > /etc/profile.d/cuda.sh'

touch install1.done
echo "You can now reboot and proceed to install2.sh"
