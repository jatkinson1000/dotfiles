# Set up a bare repo linked to remote
git clone --bare git@github.com:jatkinson1000/dotfiles.git $HOME/.dotfiles

shopt -s expand_aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no

# Try checking out git repo. If fails, back up conflicts.
dotfiles checkout
if [ $? = 0 ]; then
  echo "Checked out config.";
else
  echo "Backing up pre-existing dot files.";
  mkdir -p .dotfiles-backup
  # combine stderr and stdout | select whitespace followed by a dot | awk to print first arg | get 
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs dirname | xargs -I{} mkdir -p .dotfiles-backup/{}
  dotfiles checkout 2>&1 | egrep "\s+\." | awk {'print $1'} | xargs -I{} mv {} .dotfiles-backup/{}
fi;

dotfiles checkout
