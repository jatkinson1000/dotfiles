#
# ~/.bashrc
#

# Source global definitions
if [ -f /etc/bashrc ]; then
        . /etc/bashrc
fi

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
export VISUAL=/usr/bin/vim
export EDITOR="$VISUAL"
export BROWSER=/usr/bin/librewolf
export GPG_TTY=$(tty)

# Set other shell variables
# Source spack scripts
. ~/hpc-work/spack/share/spack/setup-env.sh

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
