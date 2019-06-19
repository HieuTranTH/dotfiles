# dotfiles
Configuration files

Setting up
git init --bare $HOME/.myconf
function dotfiles {
    /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
dotfiles config --local status.showUntrackedFiles no

Cloning to new machines
