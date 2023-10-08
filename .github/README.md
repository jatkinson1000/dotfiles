# dotfiles

[https://www.youtube.com/watch?v=fn1R-5p_j5c](https://www.youtube.com/watch?v=fn1R-5p_j5c)

This repository is for [@jatkinson1000](https://github.com/jatkinson1000)'s dotfiles
for personal configuration of machines.

The setup is heavily based on [this guide by durdn](https://www.atlassian.com/git/tutorials/dotfiles)
which is, itself, based on a [Hacker News thread](https://news.ycombinator.com/item?id=11071754).

There are different branches for different machines.  
Updates to cover all machines are made in main, with machine-specific branches.

Where possible I have annotated with comments, as whenever I look at others' dotfiles
they can be hard to interpret if you want to build on them.

## Contents

* `.dotfiles/` - The main git repo and any files I don't want to appear in $HOME
  * `LICENSE` - license for this repository
  * `.software_list` - list of software to install to ensure dotfiles operate correctly
* `.github` - directory to allow github to detect the README
  * `README.md` - description of how to set up and maintain this system.

## Branches

* `main` - Arch linux machine
* `OSX` - Apple Silicon mac

## Fresh Setup

Initialise a bare git repo in `$HOME` called something other than `.git`.  
Set up an alias for operating this repo that is something other than `git`.  
Set it so that any untracked files in `$HOME` aren't displayed in `git status`.  
Add the alias to your profile for future use.  
For example in bash:
```bash
git init --bare $HOME/.dotfiles
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

You also want to add the following to your `.bashrc`
```bash
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
_completion_loader git
$(complete -p git | sed 's/ git//') dotfiles
```

If storing on a remote repository you may want to add it now:
```bash
dotfiles remote add origin git@github.com:jatkinson1000/dotfiles.git
```

You can now operate like a normal git repo using the `dotfiles` command:
```bash
dotfiles status
dotfiles add .newdotfile
dotfiles commit -m "Added newdotfile"
dotfiles push
```

## Installation to a new machine

### References

#### General setup

* [Guide by durdn](https://www.atlassian.com/git/tutorials/dotfiles)
* [Hacker News thread](https://news.ycombinator.com/item?id=11071754)

### License

The code in this repo builds on various open source resources which I have tried to
include above.
In the spirit of FOSS it is available for others to use under [GPL-3.0](/.dotfiles/LICENSE).

### Contributions and support

If you find a better way of doing something than what I have done here please consider
[opening an issue](https://github.com/jatkinson1000/dotfiles/issues) or a pull request.

It is expected that any discussion around this repo treats everyone with respect and,
more generally, follows the guidelines articulated in the
[Python Community Code of Conduct](https://www.python.org/psf/codeofconduct/).

If you have found this repo useful, and can afford to do so, please consider
[buying me a coffee](https://www.buymeacoffee.com/jackatkinsr).
