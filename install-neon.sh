#!/bin/bash

if which virtualenv
then
	virtualenv $HOME/.neon
else
	echo python virtualenv not properly installed
	exit
fi
git clone https://github.com/NervanaSystems/neon.git
cd neon
cp Makefile Makefile.old
sed 's#\.venv#$(HOME)/.neon#' Makefile.old > Makefile
export LDFLAGS=-shared
make

