export HOMEBREW_PREFIX="/opt/homebrew"
export HOMEBREW_NO_ENV_HINTS=1
export EDITOR="nvim"
export EXA_COLORS="di=35:da=3:37"
export FZF_DEFAULT_OPTS="--color=fg:-1,fg+:-1:bold,bg+:-1,hl:underline,hl+:bold:underline,gutter:-1 --marker='' --pointer='▌ '"
export FZF_CTRL_R_OPTS="--with-nth=2.."

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

alias mastra='pnx mastra'
alias cd='z'
alias l='eza -la --icons=never --group-directories-first --sort=created --no-user --no-permissions --no-filesize --time-style="+%d %b" --time=created'
alias gs='git status'
alias gl="git log --graph --pretty=format:'%Cred%h%Creset -%C(yellow)%d%Creset %s %Cgreen(%cr)%Creset' --abbrev-commit --date=relative"
alias pull='git pull'
alias push='git push origin'
gc() {
  git clone "$@" && cd "$(basename "${@: -1}" .git)"
}
fresh() {
  # Use this when you are done with a branch and want local main to be a clean
  # copy of origin/main. This discards tracked local changes in the current repo.
  git fetch origin;
  git switch -f main;
  git reset --hard origin/main;

  # Remove untracked files and directories, but keep ignored files like caches,
  # build output, and .env files. Use `git clean -fdx` manually if you really
  # want ignored files deleted too.
  git clean -fd;
}
alias gco='git checkout'
alias gcm='git commit --message'
alias gaa='git add -A .'
alias pnd="pnpm run dev"
alias npd="npm run dev"
alias pnx="pnpm dlx"
alias oc="opencode --continue"

'-'() { cd - }
cu() { cursor "${@:-.}" }
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
# compinit

# zstyle ':completion:*' menu select
# zstyle ':completion:*' file-sort modification
# zstyle ':completion:*' completer _complete _approximate
# zstyle ':completion:*' list-colors 'ma=1;37;44' 'di=1;34' 'ln=36' 'ex=1;32' 'fi=0'
# zstyle ':completion:*' matcher-list 'm:{[:lower:][:upper:]}={[:upper:][:lower:]}'
# zstyle ':completion:*' list-separator '   '
# bindkey -M menuselect '\e' send-break

autoload -U promptinit; promptinit
prompt pure
PURE_PROMPT_SYMBOL=$
PURE_PROMPT_VICMD_SYMBOL=$
zstyle :prompt:pure:environment:title show no

_set_title() {
  local git_root
  git_root=$(git rev-parse --show-toplevel 2>/dev/null)
  if [[ -n "$git_root" ]]; then
    local repo_name=$(basename "$git_root")
    local prefix=$(git rev-parse --show-prefix 2>/dev/null)
    prefix=${prefix%/}
    if [[ -n "$prefix" ]]; then
      print -Pn "\e]0;${repo_name}/${prefix}\a"
    else
      print -Pn "\e]0;${repo_name}\a"
    fi
  else
    print -Pn "\e]0;$(basename "$PWD")\a"
  fi
}
eval "$(fnm env --use-on-cd --shell zsh)"
eval "$(zoxide init zsh)"
source "${HOMEBREW_PREFIX}/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
source <(fzf --zsh)
export PATH="$HOME/.local/bin:$PATH"
precmd_functions+=(_set_title)
chpwd_functions+=(_set_title)
_set_title

# pnpm
export PNPM_HOME="/Users/booker/.local/share/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac
# pnpm end
