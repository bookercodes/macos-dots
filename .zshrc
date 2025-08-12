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
setopt INTERACTIVE_COMMENTS

alias v=vim
alias l="eza --git --long"
alias la="eza --icons --git --all --long"
alias e='exit'
alias gp='git pull'
alias gs='git status'
alias gpo='git push origin'
alias gc='git commit'
alias gcm='git commit --message'
alias gaa='git add -A .'
alias reload=" exec zsh -li" # reload zsh

'-'() {
  cd -
}

'?'() {
  llm
}
take() { mkdir -p $@ && cd $@; }

checkpoint() {
  git add A .
  git commit -m "checkpoint at $(date '+%Y-%m-%dT%H:%M:%S%z')"
  echo "Checkpoint created"
}

zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' completer _complete _approximate # complete _approximate – tries normal completion first, then fuzzy matching.
zstyle ':completion:*' list-colors \
  'ma=1;37;44' 'di=1;34' 'ln=36' 'ex=1;32' 'fi=0'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
bindkey -M menuselect '\e' send-break


source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh

## fzf for something, or everything
# exa? or better l