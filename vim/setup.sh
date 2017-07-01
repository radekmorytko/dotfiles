#!/usr/bin/env bash

CURRENT_DIRECTORY=`pwd` # should be invoked by bootstrap.sh, so points to the root directory

ln -s "$CURRENT_DIRECTORY/vim/dot.vim/" "$HOME/.vim"

