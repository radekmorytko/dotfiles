#!/usr/bin/env bash

CURRENT_DIRECTORY=`pwd`

for symlink in $(find . -type f -name dot\*)
do
  # get rid of the leading dot and slash
  sanitised_symlink=`echo $symlink | sed  's/^\.\///'`
  # change dot.dotfile to .dotfile
  symlink_filename=`basename $symlink | sed 's/^dot//'`
  
  ln -s "$CURRENT_DIRECTORY/$sanitised_symlink" "$HOME/$symlink_filename"
done


