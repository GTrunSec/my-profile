if [[ "$OSTYPE" == "linux-gnu" ]]; then
    rm -rf $HOME/.config/nixpkgs/nixos/overlays/.git/index.lock
elif [[ "$OSTYPE" == "darwin"* ]]; then
    rm -rf $HOME/project/gtrun-profile/.git/modules/dotfiles/emacs/emacs.d/private/emacs-snippets/index.lock
fi

