#!/bin/bash

for f in .??*
do
    [[ $f == ".git" ]] && continue
    [[ $f == ".DS_Store" ]] && continue
    # ~/.claude は dotfiles で管理せず、ホームに直接置く
    [[ $f == ".claude" ]] && continue

    ln -sf $(echo $(pwd))/$f $HOME/$f
done

ln -sf $(echo $(pwd))/aquaskk/keymap.conf $HOME/Library/Application\ Support/AquaSKK/

# Karabiner はファイルを置き換えて保存するため、ディレクトリごとリンクする
mkdir -p $HOME/.config
if [ -d "$HOME/.config/karabiner" ] && [ ! -L "$HOME/.config/karabiner" ]; then
    echo "~/.config/karabiner が実ディレクトリのため、リンクしません"
else
    ln -sfn $(echo $(pwd))/karabiner $HOME/.config/karabiner
fi
