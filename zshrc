function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco --query "$LBUFFER")
  CURSOR=$#BUFFER
  zle clear-screen
}

zle -N peco-select-history
bindkey '^r' peco-select-history

autoload -U compinit
compinit

export LSCOLORS=exfxcxdxbxegedabagacad
export LS_COLORS='di=34:ln=35:so=32:pi=33:ex=31:bd=46;34:cd=43;34:su=41;30:sg=46;30:tw=42;30:ow=43;30'

zstyle ':completion:*' list-colors 'di=34' 'ln=35' 'so=32' 'ex=31' 'bd=46;34' 'cd=43;34'

HISTFILE=~/.zsh_history
export HISTSIZE=1000
export SAVEHIST=100000
setopt hist_ignore_dups
setopt share_history
setopt hist_ignore_all_dups
setopt hist_ignore_space

function history-all { history -E 1}

autoload -Uz vcs_info
setopt prompt_subst
zstyle ':vcs_info:git:*' check-for-changes true
zstyle ':vcs_info:git:*' stagedstr "%F{magenta}!"
zstyle ':vcs_info:git:*' unstagedstr "%F{yellow}+"
zstyle ':vcs_info:*' formats "%F{cyan}%c%u[%b]%f"
zstyle ':vcs_info:*' actionformats '[%b|%a]'
precmd () { vcs_info }

NEWLINE=$'\n'
PROMPT='%F{green}%n@%m:%~%f%F{cyan}$vcs_info_msg_0_%f${NEWLINE}$ '

alias ls='ls --color=auto'
#alias dir='dir --color=auto'
#alias vdir='vdir --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
# some more ls aliases

alias ll='ls -alF'
alias la='ls -A'
alias l='ls -CF'

if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
  # configuration for WSL (VcxSrv)
  export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
fi

eval $(ssh-agent)
alias vim=nvim
export PATH=$HOME/.local/bin:$PATH

if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL=$HOME/.deno
  export PATH=$DENO_INSTALL/bin:$PATH
fi

# attach tmux session if exists
alias tmux='tmux attach || tmux new'
