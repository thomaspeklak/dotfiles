#!/bin/bash

for rc in *      
do
  if [ "$rc" != README.md ]
  then
    if [ "$rc" != create-symlinks.sh ]
    then
      ln -fs `pwd`/$rc ~/.$rc
    fi
  fi
done

