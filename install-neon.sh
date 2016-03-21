#!/bin/bash

#virtualenv $HOME/.neon
#git clone https://github.com/NervanaSystems/neon.git
cd neon
cp Makefile Makefile.old
sed 's#\.venv#$(HOME)/.neon#' Makefile.old > Makefile
export LDFLAGS=-shared
make

