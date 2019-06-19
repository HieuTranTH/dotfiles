# dotfiles
Configuration files

Setting up

```bash
git init --bare $HOME/.myconf
function dotfiles {
    /usr/bin/git --git-dir=$HOME/.myconf/ --work-tree=$HOME $@
}
dotfiles config --local status.showUntrackedFiles no
```

Cloning to new machines

```bash
git clone --bare https://github.com/HieuTranTH/dotfiles.git $HOME/.myconf
git --git-dir=$HOME/.myconf/ --work-tree=$HOME checkout
```

If there is any file would be overwritten, remove them then checkout again.
After checking out successfully, open another terminal or source the new
.bashrc and add remote tracking to the bare cloned repo.

```bash
dotfiles config --local status.showUntrackedFiles no
dotfiles config --local user.email="hieutran.th.358@gmail.com"
dotfiles config --local --add remote.origin.fetch "+refs/heads/*:refs/remotes/origin/*"
dotfiles fetch
```
