# -- GENERAL ZSH SETTINGS --
# Load zsh autocompletion and prompts
autoload -Uz compinit promptinit
compinit
promptinit
# Set zsh prompt
prompt redhat
# Set completion menu to be navigable
zstyle ':completion:*' menu select

# Set parameters for bash-history
export HISTSIZE=1000000
export SAVEHIST=$HISTSIZE
setopt HIST_IGNORE_DUPS

# Set default programs (but restore emacs shell bindings)
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export BROWSER=/usr/bin/librewolf
bindkey -e

# Set TTY for GPG passkey prompting
export GPG_TTY=$(tty)

# Set other shell variables
export KAGGLE_CONFIG_DIR=~/.config/kaggle

# -- ALIASES --
# Set useful aesthetic aliases
alias ls="ls --color"
alias grep="grep --color"

# Custom viminit location, but don't conflict with Neovim
alias vim='vim -u ~/.config/vim/vimrc'

# Set up alias for controlling dotfiles via git and allow completions
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
unsetopt completealiases

# -- FUNCTIONS --
# Get non-password value from pass (adapted from dbrumbaugh)
# e.g. `show-pass-value github username`
show-pass-val () {
  if [[ "$#" == 1 ]]; then
    # If no extra args then print password
    pass $1 | head -1
  else
    # search for $2 after ": " and print
    pass $1 | awk -F ": " "/$2/"'{print $2}'
  fi
}

# -- OTHER PROGRAM SETTINGS --
# Add fuzzyfinder
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# Add Walk
function lk {
  cd "$(walk "$@")"
}

. "$HOME/.cargo/env"
