autoload -Uz select-word-style
select-word-style default

zstyle ':zle:*' word-chars " /-;@:{},|"
zstyle ':zle:*' word-style unspecified

autoload -Uz vcs_info
zstyle ':vcs_info:*' enable git
zstyle ':vcs_info:*' check-for-chages true
zstyle ':vcs_info:*' stagedstr "+"
zstyle ':vcs_info:*' unstagedstr "*"
zstyle ':vcs_info:*' formats '(%b%c%u)'
zstyle ':vcs_info:*' actionformats '(%b(%a)%c%u)'

# プロンプト表示直前にvcs_info呼び出し
precmd () {
    psvar=()
    LANG=en_US.UTF-8 vcs_info
    [[ -n "$vcs_info_msg_0_" ]] && psvar[1]="$vcs_info_msg_0_"
}
#add-zsh-hook precmd _update_vcs_info_msg
PROMPT=""
PROMPT+="%F{yellow}%* %f"
# PROMPT="%{${fg[green]}%}"
PROMPT+="%n%{${reset_color}%}"
PROMPT+="@%m%f"
PROMPT+="%1(v|%F{red}%1v%f|)"
# RPROMPT='%F{green}%d%f'
PROMPT+=':%F{green}%~%f'
PROMPT+="
(*'0'){ "

autoload -Uz colors
colors

fpath=(~/.zsh/completion $fpath)

autoload -Uz compinit
compinit

zstyle ':completion:*' matcher-list 'm:{a-z}={A-Z}'
zstyle ':completion:*' list-colors "${LS_COLORS}"

setopt ignoreeof
setopt always_last_prompt
setopt auto_cd
function chpwd() { ls -lGF }
setopt equals
setopt complete_in_word

autoload -Uz compinit
compinit

setopt auto_list
setopt auto_menu
setopt list_packed
setopt list_types

bindkey -e

autoload history-search-end
zle -N history-beginning-search-backward-end history-search-end
zle -N history-beginning-search-forward-end history-search-end

bindkey "^P" history-beginning-search-backward-end
bindkey "^N" history-beginning-search-forward-end

HISTFILE=$HOME/.zsh_history
HISTSIZE=1000000
SAVEHIST=1000000

LISTMAX=1000

setopt extended_history
# HISTTIMEFORMAT="[%Y/%M/%D %H:%M:%S] "

setopt hist_reduce_blanks
setopt share_history

# export LESS='--tabs=4 --no-init --LONG-PROMPT --ignore-case'
alias activate='source bin/activate'
alias cleantrash='/bin/rm -rf $HOME/.Trash/*'
alias cp='cp -i'
alias e="emacs"
alias g="git"
alias grep="grep --color"
alias history='history -E 1'
alias ll='(){ls -l $* | parrotsay}'
alias ls='ls -GF'
alias mv='mv -i'
alias sudo="sudo " # For using local alias
alias t="tig"
alias timestamp='date +%s.%N'
alias unmount='diskutil unmount'
alias julia="$HOME/julia/julia"

# source ~/.git-completion.

# set PATH so it includes user's private bin if it exists

# local setting in MacBookAir
alias brew='env PATH=${PATH/\/Users\/yuta_oohigashi\/.pyenv\/shims:/} brew'
if [ -x "`which emacs 2>/dev/null`" ]; then
    EDITOR='emacsclient'
    alias vim='emacs'
    alias vimtutor='emacs /usr/local/share/emacs/24.4/etc/tutorials/TUTORIAL.ja'
fi
if [ -x "`which rmtrash 2>/dev/null`" ]; then
    alias rm='rmtrash'
else
    if ! [ -d "$HOME/.Trash/" ];then
        mkdir $HOME/.Trash/
    fi
    alias rm='mv --backup=numbered --target-directory=${HOME}/.Trash'
fi


case "$TERM" in
    dumb | emacs)
        PROMPT="%m:%~> "
        unsetopt zle
        ;;
esac

function exists { which $1 &> /dev/null }
exists
if exists percol; then
    function percol_select_history() {
        local tac
        exists gtac && tac="gtac" || { exists tac && tac="tac" || { tac="tail -r" } }
        BUFFER=$(fc -l -n 1 | eval $tac | percol --query "$LBUFFER")
        CURSOR=$#BUFFER # move cursor
        zle -R -c # refresh
    }

    zle -N percol_select_history
    bindkey '^R' percol_select_history
fi

if [ -f "$HOME/.zshrc_local" ];then
    . "$HOME/.zshrc_local"
fi

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

if [ -d "$HOME/julia/libmxnet" ] ; then
    MXNET_HOME="$HOME/julia/libmxnet"
fi

if [[ "$TERM" == "dumb" ]]
then
  unsetopt zle
  unsetopt prompt_cr
  unsetopt prompt_subst
  if whence -w precmd >/dev/null; then
    unfunction precmd
  fi
  if whence -w preexec >/dev/null; then
    unfunction preexec
  fi
  PS1='$ '
fi

function mkdircd () { mkdir -p "$@" && eval cd "\"\$$#\""; }

# added by travis gem
[ -f /Users/yuta_oohigashi/.travis/travis.sh ] && source /Users/yuta_oohigashi/.travis/travis.sh

export PATH=$HOME/.nodebrew/current/bin:$PATH

# The next line updates PATH for the Google Cloud SDK.
if [ -f '/Users/h-1456/google-cloud-sdk/path.zsh.inc' ]; then source '/Users/h-1456/google-cloud-sdk/path.zsh.inc'; fi

# The next line enables shell command completion for gcloud.
if [ -f '/Users/h-1456/google-cloud-sdk/completion.zsh.inc' ]; then source '/Users/h-1456/google-cloud-sdk/completion.zsh.inc'; fi


export OBJC_DISABLE_INITIALIZE_FORK_SAFETY=YES
