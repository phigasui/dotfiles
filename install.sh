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

# herdr は ~/.config/herdr に socket・ログ・session.json などが同居するため、config.toml だけをファイル単位でリンクする
mkdir -p "$HOME/.config/herdr"
if [ -e "$HOME/.config/herdr/config.toml" ] && [ ! -L "$HOME/.config/herdr/config.toml" ]; then
    echo "~/.config/herdr/config.toml が実ファイルのため、リンクしません"
else
    ln -sf "$(pwd)/herdr/config.toml" "$HOME/.config/herdr/config.toml"
fi

# alpatiled LaunchAgent
ALPATILED_PLIST="$HOME/phigasui/alpatile/launchd/com.phigasui.alpatiled.plist"
if [ -f "$ALPATILED_PLIST" ]; then
    mkdir -p "$HOME/Library/LaunchAgents"
    ln -sf "$ALPATILED_PLIST" "$HOME/Library/LaunchAgents/com.phigasui.alpatiled.plist"
fi
