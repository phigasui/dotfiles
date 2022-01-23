#!/bin/bash

for f in .??*
do
    [[ $f == ".git" ]] && continue
    [[ $f == ".DS_Store" ]] && continue

    ln -sf $(echo $(pwd))/$f $HOME/$f
done

ln -sf $(echo $(pwd))/aquaskk/keymap.conf $HOME/Library/Application\ Support/AquaSKK/
