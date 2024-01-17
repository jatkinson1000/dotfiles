# .bash_profile

# User specific environment and startup programs
# Add any necessary directories to $PATH
PATH=$HOME/bin/bin:$PATH:$HOME/bin
export PATH

# Source .bashrc: Conditional execution "If ~/.bashrc is a file then run it."
# Get the aliases and functions
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Run ssh-agent if necessary

. "$HOME/.cargo/env"
