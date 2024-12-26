#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- BASH PARAMETERS --

# Set bash prompt
export PS1='[\u@\h \W]\$ '

# Set parameters for bash-history
export HISTSIZE=1000000 
export SAVEHIST=$HISTSIZE
export HISTCONTROL=ignoredups

# Set default programs
export VISUAL=/usr/bin/nvim
export EDITOR="$VISUAL"
export BROWSER=/usr/bin/librewolf

# Set other shell variables

# -- ALIASES --
# Get bash completions - should be autoloaded
# source /usr/share/bash-completion/bash_completion

# Set useful aesthetic aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Custom viminit location, but don't conflict with Neovim
alias vim='vim -u ~/.config/vim/vimrc'

# Set up alias for controlling dotfiles via git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
_completion_loader git
$(complete -p git | sed 's/ git//') dotfiles

# Other machine specific aliases
alias wlsunset='wlsunset -l 52.2 -L 0.1 -t 2000 &'

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
_completion_loader pass
$(complete -p pass | sed 's/ pass//') show-pass-val

. "$HOME/.cargo/env"
