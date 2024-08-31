function npeco() {
  previousTERM=$TERM
  export TERM=xterm

  peco_flags="$@"

  peco $peco_flags

  export TERM=$previousTERM
}

alias peco=npeco

function peco-select-history() {
  BUFFER=$(\history -n -r 1 | peco)
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
if [ -e /usr/local/bin/kubectl ]; then
    precmd () { vcs_info; kubecontext=$(kubectl config current-context) }
    PROMPT='%F{green}%n@%m:%~%f%F{cyan}$vcs_info_msg_0_%f[kube:$kubecontext] ${NEWLINE}$ '
else
    precmd () { vcs_info; }
    PROMPT='%F{green}%n@%m:%~%f%F{cyan}$vcs_info_msg_0_%f ${NEWLINE}$ '
fi


NEWLINE=$'\n'

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

# if [ $(uname -r | sed -n 's/.*\( *Microsoft *\).*/\1/ip') ]; then
#   # configuration for WSL (VcxSrv)
#   export DISPLAY=$(cat /etc/resolv.conf | grep nameserver | awk '{print $2}'):0
# fi

alias vim=nvim
export PATH=$HOME/.local/bin:$PATH

if [ -d "$HOME/.cargo" ]; then
  source "$HOME/.cargo/env"
fi

if [ -d "$HOME/go/bin" ]; then
  export PATH=$PATH:$HOME/go/bin
fi

if [ -d "$HOME/.deno" ]; then
  export DENO_INSTALL=$HOME/.deno
  export PATH=$DENO_INSTALL/bin:$PATH
fi

# attach tmux session if exists
if [[ -z "$TMUX" ]] ;then
    ID="$( tmux ls | grep -vm1 attached | cut -d: -f1 )" # get the id of a deattached session
    if [[ -z "$ID" ]] ;then # if not available create a new one
        tmux new-session
    else
        tmux attach-session -t "$ID" # if available attach to it
    fi
fi

export PATH=$PATH:/opt/metasploit-framework/bin/msfconsole

if [ -d "/usr/local/go/bin" ]; then
    export PATH=$PATH:/usr/local/go/bin
fi

export PATH="$PATH:/opt/nvim-linux64/bin"

alias k=kubectl

if [ -d "$HOME/go/bin" ]; then
    export PATH=$PATH:"$HOME/go/bin"
fi

if [ -d $HOME/.krew ]; then
    export PATH=$PATH:"$HOME/.krew/bin"
fi


# attach ssh-agent PID if it exists
# else then new ssh-agent session
#
if [ -z "$SSH_AUTH_SOCK" ]; then
    # Check for a currently running instance of the agent
    RUNNING_AGENT="`ps -ax | grep 'ssh-agent -s' | grep -v grep | wc -l | tr -d '[:space:]'`"
    if [ "$RUNNING_AGENT" = "0" ]; then
        # Launch a new instance of the agent
        ssh-agent -s &> $HOME/.ssh/ssh-agent
    fi
    eval `cat $HOME/.ssh/ssh-agent`
fi

export KUBECONFIG=$HOME/.kube/config:$HOME/.kube/config-abcke

export PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

if [ -e /usr/local/bin/kubectl ]; then
    [[ /usr/local/bin/kubectl ]] && source <(kubectl completion zsh)
fi
