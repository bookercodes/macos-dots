export PATH=$PATH:/Users/booker/.local/bin

export PNPM_HOME="/Users/booker/Library/pnpm"
# export XDG_CONFIG_HOME=~/.config
export EDITOR=vim

case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

eval "$(starship init zsh)"

bindkey -v
# bindkey -M vicmd "/" history-incremental-search-backward

zmodload -i zsh/complist

KEYTIMEOUT=1
HIST_SIZE=1000000000
SAVE_HIST=1000000000
#HISTFILE="$XDG_CACHE_HOME/zsh_history" # move histfile to cache

setopt AUTO_CD     
setopt HIST_IGNORE_DUPS
setopt SHARE_HISTORY

alias v=vim
alias l='ls --color=auto'
alias la='ls -lathr'
alias e='exit'
alias gp='git pull'
alias gs='git status'
alias gpo='git push origin'
alias gc='git commit'
alias gcm='git commit --message'
alias gaa='git add -A .'
'-'() {
  cd -
}

'?'() {
  llm
}

mkcd() {
  if [ ! -n "$1" ]; then
    echo "Enter a directory name"
  elif [ -d $1 ]; then
    echo "\`$1' already exists"
  else
    mkdir $1 && cd $1
  fi
}

zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' completer _complete _approximate # complete _approximate – tries normal completion first, then fuzzy matching.
zstyle ':completion:*' list-colors \
  'ma=1;37;44' 'di=1;34' 'ln=36' 'ex=1;32' 'fi=0'
zstyle ':completion:*' group-name ''
bindkey -M menuselect '\e' send-break

source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## fzf for something, or everything
# exa? or better l