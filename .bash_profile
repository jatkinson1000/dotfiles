#
# ~/.bash_profile
#

# Source .bashrc: Conditional execution "If ~/.bashrc is a file then run it."
[[ -f ~/.bashrc ]] && . ~/.bashrc

# Add any necessary directories to $PATH

# Run ssh-agent if necessary

. "$HOME/.cargo/env"
