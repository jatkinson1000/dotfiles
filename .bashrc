#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

# Load modules Levante
module load git                             # load git (why not in system?)
module load gcc                             # newer than standard GCC version
module load nano                            # load nano (why not in system?)
module load python3                         # python3 for processing

# -- BASH PARAMETERS --

# Set bash prompt
export PS1='[\u@\h \W]\$ '

# Set parameters for bash-history
export HISTSIZE=10000 
export HISTCONTROL=ignoredups

# Set default programs
export VISUAL=/usr/bin/vim
export EDITOR="$VISUAL"
# export BROWSER=/usr/bin/librewolf

# Set other shell variables
# Levante
# export MODULES_RUN_QUARANTINE=""
export I_MPI_CC=icc                         # cmake and MPI build flags
export I_MPI_CXX=icpc
export I_MPI_F77=ifort
export I_MPI_F90=ifort
export MPLBACKEND="PS"                      # backend for python / matplotlib
export HOSTNICK="Levante"                   # nickname for the host machine
export SCRATCH="/scratch/b/b382543"         # my own directory on scratch
export HOME="/home/b/b382543"               # my own directory on scratch
export WORK_GS="/work/bb1097/b380867"       # GS work dir


# -- ALIASES --
# Get bash completions - should be autoloaded
# source /usr/share/bash-completion/bash_completion

# Set useful aesthetic aliases
alias grep='grep --color=auto'
alias ls='ls -lh --color=auto'

# Custom viminit location, but don't conflict with Neovim
alias vim='vim -u ~/.config/vim/vimrc'
alias nvim='vim -u ~/.config/vim/vimrc'

# Set up alias for controlling dotfiles via git
alias dotfiles='git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
_completion_loader git
$(complete -p git | sed 's/ git//') dotfiles

# Other machine specific aliases
alias wlsunset='wlsunset -l 52.2 -L 0.1 -t 2000 &'

# Levante aliases
alias scratch="cd ${SCRATCH}"
alias work="cd ${WORK}"
alias cmake='cmake -DCMAKE_Fortran_COMPILER=ifort'
alias qv='squeue -u b382543'

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
