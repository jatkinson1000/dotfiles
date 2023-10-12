#
# ~/.bashrc
#

# If not running interactively, don't do anything
# [[ $- != *i* ]] && return

# -- BASH PARAMETERS --

# Set bash prompt
PS1='[\u@\h \W]\$ '

# Set parameters for bash-history
HISTSIZE=10000 
HISTCONTROL=ignoredups

# Set default programs
EDITOR=/usr/bin/vim
# BROWSER=/usr/bin/librewolf

export VIMINIT="source ~/.config/vim/vimrc"

# -- ALIASES --
# Get bash completions - should be autoloaded
# source /usr/share/bash-completion/bash_completion

# Set useful aesthetic aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Set up alias for controlling dotfiles via git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
# _completion_loader git
# $(complete -p git | sed 's/ git//') dotfiles

# Other machine specific aliases
