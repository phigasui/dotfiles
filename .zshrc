autoload -Uz compinit
autoload -Uz vcs_info
autoload -Uz colors

setopt PROMPT_SUBST

precmd () {
    vcs_info
    compinit
    colors
}

zstyle ':completion:*' insert-tab false
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-colors "${LS_COLORS}"
zstyle ':completion:*' menu select=1

zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:git:*' check-for-chages true
zstyle ':vcs_info:*' stagedstr '%F{red}+'
zstyle ':vcs_info:*' unstagedstr '%F{blue}*'
zstyle ':vcs_info:*' formats '%F{green}%c%u%b%f'
zstyle ':vcs_info:*' actionformats '%F{red}%c%u%b(%a)%f'

bindkey '^P' history-beginning-search-backward
bindkey '^N' history-beginning-search-forward

PROMPT=''
PROMPT+='%* '
# PROMPT+='%n@%m'
PROMPT+='%F{blue}%~%f '
PROMPT+='$vcs_info_msg_0_'
PROMPT+="
(*'0'){ "

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

LISTMAX=1000

# export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
alias activate='source bin/activate'
alias cleantrash='/bin/rm -rf $HOME/.Trash/*'
alias cp='cp -i'
alias g='git'
alias grep='grep --color'
alias history='history -E 1'
alias ls='ls -GF'
alias mv='mv -i'
alias sudo='sudo ' # For using local alias
alias timestamp='date +%s'
alias unmount='diskutil unmount'
alias emacsd="emacs --daemon"
alias ed='emacsd'
alias emacsc='emacsclient -nw'
alias ec='emacsc'
alias emacsq="emacsclient -e '(kill-emacs)'"
alias eq='emacsq'


# local setting in MacBookAir
if [ -x "`which emacs 2>/dev/null`" ]; then
    EDITOR='emacsclient'
fi
if [ -x "`which trash-put 2>/dev/null`" ]; then
    alias rm='trash-put'
else
    if ! [ -d "$HOME/.Trash/" ];then
        mkdir $HOME/.Trash/
    fi
    alias rm='mv --backup=numbered --target-directory=${HOME}/.Trash'
fi

if [ -f "$HOME/.zshrc_local" ];then
    . "$HOME/.zshrc_local"
fi

# loadpaths
function loadpath() {
    libpath=${1:?"You have to specify a library path"}
    if [ -d "$libpath" ];then #ファイルの存在を確認
        PATH="$libpath:$PATH"
    fi
}

loadpath $HOME/.bin
loadpath $HOME/.pyenv/shims
loadpath $HOME/.rbenv/shims
loadpath $HOME/flutter/bin
loadpath $HOME/flutter/bin
loadpath $HOME/julia/usr/bin
loadpath $HOME/.nodenv/shims
loadpath /opt/homebrew/bin


# commands
function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }
