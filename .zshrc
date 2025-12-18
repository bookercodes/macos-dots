export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_NO_ENV_HINTS=1
export EDITOR="nvim"
export EXA_COLORS="di=35:da=3:37"
export FZF_DEFAULT_OPTS="--color=bg+:#FF0000,gutter:-1"

HISTSIZE=1000000000
SAVEHIST=1000000000
mkdir -p "${XDG_CACHE_HOME}/zsh"
HISTFILE="${XDG_CACHE_HOME}/zsh/zsh_history"
setopt HIST_IGNORE_ALL_DUPS
setopt SHARE_HISTORY

KEYTIMEOUT=1
setopt AUTO_CD
setopt INTERACTIVE_COMMENTS

bindkey -v
bindkey '\C-r' history-incremental-search-backward

alias cd='z'
alias l='eza -la --icons=never --group-directories-first --sort=created --no-user --no-permissions --no-filesize --time-style="+%d %b" --time=created'
alias gs='git status'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias pull='git pull'
alias push='git push origin'
alias gc='git commit'
alias gco='git checkout'
alias gcm='git commit --message --no-verify'
alias gaa='git add -A .'
alias pnd="pnpm run dev"
alias npd="npm run dev"
alias pnx="pnpm dlx"
alias cma="pnx create-mastra@latest"
alias r='exec zsh -li'
alias cl="claude"
alias clear='echo "use Control+L unless you like wasting your time and u want RSI"'
alias vim='echo "use v or nvim"'

'-'() { cd - }
c() { cursor "${@:-.}" }
v() { $EDITOR "${@:-.}" }

take() {
  mkdir -p "$@"
  cd "${@: -1}"
}

check() {
  git add -A .
  git commit -m "checkpoint at $(date '+%Y-%m-%dT%H:%M:%S%z')" -n
  echo "Checkpoint created"
}

path() {
  echo "$PATH" | tr ':' '\n'
}

fpath+=("${HOMEBREW_PREFIX}/share/zsh/site-functions")
zmodload zsh/complist
autoload -U compinit
compinit

zstyle ':completion:*' menu select
zstyle ':completion:*' file-sort modification
zstyle ':completion:*' completer _complete _approximate
zstyle ':completion:*' list-colors 'ma=1;37;44' 'di=1;34' 'ln=36' 'ex=1;32' 'fi=0'
zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
zstyle ':completion:*' list-separator '   '
bindkey -M menuselect '\e' send-break

autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=$
PURE_PROMPT_VICMD_SYMBOL='VIS'

eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source <(fzf --zsh)
