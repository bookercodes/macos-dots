eval "$(fnm env --use-on-cd --shell zsh)"

export HOMEBREW_PREFIX="/opt/homebrew"
export EDITOR="nvim"
export HOMEBREW_NO_ENV_HINTS=1

# History
HISTSIZE=1000000000
SAVEHIST=1000000000
mkdir -p "${XDG_CACHE_HOME}/zsh"
HISTFILE="${XDG_CACHE_HOME}/zsh/zsh_history"
setopt HIST_IGNORE_DUPS SHARE_HISTORY INTERACTIVE_COMMENTS


# Zsh options
KEYTIMEOUT=1
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS
bindkey -v
bindkey '\C-r' history-incremental-search-backward

# Aliases
alias l='eza --git --long'
alias la='eza --icons --git --all --long'
alias gp='git pull'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias gs='git status'
alias gpo='git push origin'
alias gc='git commit'
alias gcm='git commit --message'
alias gaa='git add -A .'
alias e='exit'
alias r='exec zsh -li'
alias vim='echo "use v or nvim"'

# Functions
'-'() { cd -; }
'?'() { llm; }
c() { cursor "${@:-.}"; }
v() { $EDITOR "${@:-.}"; }
take() {
  mkdir -p "$@"
  local last
  last="${@: -1}"
  cd "$last"
}
checkpoint() {
  git add -A .
  git commit -m "checkpoint at $(date '+%Y-%m-%dT%H:%M:%S%z')"
  echo "Checkpoint created"
}
path() { echo "$PATH" | tr ':' '\n' }

fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")

# Modules and completion
zmodload zsh/complist
autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' list-colors \
  'ma=1;37;44' 'di=1;34' 'ln=36' 'ex=1;32' 'fi=0'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-separator '   '
bindkey -M menuselect '\e' send-break

# Prompt and plugins
autoload -U promptinit; promptinit
prompt pure
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# $ for user like the gods intended
PURE_PROMPT_SYMBOL=$
PURE_PROMPT_VICMD_SYMBOL='VIS'
