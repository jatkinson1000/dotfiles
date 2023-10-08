#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# -- BASH PARAMETERS --

# Set bash prompt
PS1='[\u@\h \W]\$ '

# Set parameters for bash-history
HISTSIZE=10000 
HISTCONTROL=ignoredups

# Set default programs
EDITOR=/usr/bin/nvim
BROWSER=/usr/bin/librewolf

# -- ALIASES --

# Set useful aesthetic aliases
alias grep='grep --color=auto'
alias ls='ls --color=auto'

# Set up alias for controlling dotfiles via git
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'

# Other machine specific aliases
alias wlsunset='wlsunset -l 52.2 -L 0.1 -t 2000 &'
