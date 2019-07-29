#!/usr/bin/env bash
rm -rf ~/.emacs
cp -r ../dotfiles/emacs.d/lisp ~/.emacs.d
cd ~/.emacs.d
make compile

ln -s ../dotfiles/emacs/emacs.d/init.org  ~/.emacs.d
ln -s ../dotfiles/emacs/emacs.d/init.el  ~/.emacs.d
