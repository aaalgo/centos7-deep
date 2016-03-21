#!/bin/bash

#git clone https://github.com/NervanaSystems/neon.git
#if which virtualenv
#then
#	virtualenv $HOME/.neon
#else
#	echo python virtualenv not properly installed
#	exit
#fi
cd neon
. $HOME/.neon/bin/activate
cp Makefile Makefile.old
sed 's#\.venv#$(HOME)/.neon#' Makefile.old > Makefile
export LDFLAGS=-shared
make

