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
* `cheyenne` - Cheyenne HPC (NCAR)
* `levante` - Levante HPC (DKRZ)
* `carpentries` - Simplified profiles to use when teaching


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

### Clone, setup, and checkout

This is a complete explanation of the steps taken on a new machine.
If you are satisfied you can skip ahead to [quickstart](#quickstart).

The first step is to do a `--bare` clone of the repository from git to the new machine.
As with the init steps above we want to place this in `$HOME/.dotfiles` to have it
hidden in general.\
Note that if cloning via ssh you will need to have generated a key and added the public
to the remote in advance.
```bash
git clone --bare git@github.com:jatkinson1000/dotfiles.git $HOME/.dotfiles
```

The next step is to set up a `dotfiles` alias to `git` as above which will handle the
non-standard git-dir and work-tree configuration:
```bash
shopt -s expand_aliases
alias dotfiles='/usr/bin/git --git-dir=$HOME/.dotfiles/ --work-tree=$HOME'
dotfiles config --local status.showUntrackedFiles no
```

Finally, populate the dotfiles by checking out from the remote:
```
dotfiles checkout
```

Note, that if you have existing dotfiles in your home directory, the above command will
fail due to conflicts.
To make this seamless we can use the following script to back up any dotfiles that would
be overwritten to a `.dotfiles-backup/` directory.
```bash
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
```

#### Quickstart

Rather than doing all of the above manually I have combined it into a shell script at
[.dotfiles/dotfiles_install.sh](jatkinson1000/dotfiles/.dotfiles/dotfiles_install.sh)
which can be run from the terminal with, for example:
```
curl -s https://raw.githubusercontent.com/jatkinson1000/dotfiles/refs/heads/main/.dotfiles/dotfiles_install.sh | bash
```
Remember to ensure that you are happy with what somebody else's scripts are doing before
you execute them!

### source/logout/reboot

At this point you will want to reload your various configs and profiles.
The easiest way might be to logout and back in, restart the terminal, or reboot the
machine.

### Install software

At this point you may receive errors about missing files/software when profiles are
sourced.
Track these down and install things if necessary, or modify the profiles to remove the
offending lines (ideally oin a new branch for this machine).

### Decrypt private files

The following files need decrypting:
```bash
gpg --decrypt .config/neomutt/aliases.mutt.asc > .config/neomutt/aliases.mutt
gpg --decrypt .config/neomutt/acounts/gmail-local.asc > .config/neomutt/accounts/gmail-local
gpg --decrypt .config/mbsync.asc > .config/mbsync
gpg --decrypt .config/msmtp/config.asc > .config/msmtp/config
```
Remember to re-encrypt them if you ever want to push back up any changes.

### Additional steps

After installing these dotfiles you will also need to set up passwords through
[`pass`](https://www.passwordstore.org/). This has not been included in this repo for
obvious reasons.

You will also need to set up and/or import ssh/gpg keys for the machine and add the
public keys to any other machines as necessary.

You will need to enable the systemd jobs for mail updates and syncing:
```bash
systemctl daemon-reload
systemctl enable --user mbsync.service
systemctl start --user mbsync.service
systemctl enable --user goimapnotify@gmail.service
systemctl start --user goimapnotify@gmail.service
```
if doing so, consider extending the gpg timeout in `.gnupg/gpg-agent.conf`,
or stopping the systemd service when you don't want to be disturbed.

If you cannot send mail automatically you may need to `chmod 600 .config/msmtp/config`.  
Similarly for weather in waybar you may need to `chmod +x .config/waybar/scripts/weather.py`.


## References

### General setup

* [Guide by durdn](https://www.atlassian.com/git/tutorials/dotfiles)
* [Hacker News thread](https://news.ycombinator.com/item?id=11071754)

### Neomutt

* [Neomutt workflow - blog post](https://gideonwolfe.com/posts/workflow/neomutt/intro/)
* [Neomutt, mbsync, msmtp, notmuch - blog post](https://blog.flaport.net/configuring-neomutt-for-email.html)
* [imapnotify for push notifications - Arch page](https://wiki.archlinux.org/title/Isync)

### Configs

* [wezterm](https://wezfurlong.org/wezterm/config/files.html)


## License

The code in this repo builds on various open source resources which I have tried to
include above.
In the spirit of FOSS it is available for others to use under [GPL-3.0](/.dotfiles/LICENSE).


## Contributions and support

If you find a better way of doing something than what I have done here please consider
[opening an issue](https://github.com/jatkinson1000/dotfiles/issues) or a pull request.

It is expected that any discussion around this repo treats everyone with respect and,
more generally, follows the guidelines articulated in the
[Python Community Code of Conduct](https://www.python.org/psf/codeofconduct/).

If you have found this repo useful, and can afford to do so, please consider
[buying me a coffee](https://www.buymeacoffee.com/jackatkinsr).
