#!/bin/bash
# install.sh
pdir="y.sh"
bin=""

bin="y"
[ -f "$HOME/git/repo/mybin/$bin" ] && rm "$HOME/git/repo/mybin/$bin"
ln $HOME/git/repo/myscripts/$pdir/$bin $HOME/git/repo/mybin/$bin
