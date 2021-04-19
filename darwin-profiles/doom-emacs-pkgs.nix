{ config, lib, pkgs, ... }:

let

  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom sync";
  updateInit = "bash .doom.d/bin/emacs.sh";

  emacs-final = (pkgs.emacsGcc.override ({
    # frame Flicker ?
    # withImageMagick = true;
    # imagemagick = pkgs.imagemagick;
  })).overrideAttrs
    (old: rec {
      configureFlags = (old.configureFlags or [ ]) ++ [
      ];
      patches = [
        (
          pkgs.fetchpatch {
            name = "tramp-detect-wrapped-gvfsd.patch";
            url = "https://raw.githubusercontent.com/nix-community/emacs-overlay/master/patches/tramp-detect-wrapped-gvfsd.patch";
            sha256 = "sha256-nW2582royQJ1Prg1jy6wpv2uGctzomByHK2eZIo4f+c=";
          }
        )
      ];

      postPatch = old.postPatch + ''
        substituteInPlace lisp/loadup.el \
        --replace '(emacs-repository-get-version)' '"${pkgs.emacsGcc.src.rev}"' \
        --replace '(emacs-repository-get-branch)' '"master"'
      '';

      postInstall = old.postInstall or "" + ''
        ln -snf $out/lib/emacs/28.0.50/native-lisp $out/native-lisp
        ln -snf $out/lib/emacs/28.0.50/native-lisp $out/Applications/Emacs.app/Contents/native-lisp
        cat <<EOF> $out/bin/run-emacs.sh
        #!/usr/bin/env bash
        set -e
        exec $out/bin/emacs-28.0.50 "\$@"
        EOF
        chmod a+x $out/bin/run-emacs.sh
        ln -snf ./run-emacs.sh $out/bin/emacs
      '';
    });
in

{
  home.packages = with pkgs;[
    emacs-final
  ];



  home.file.".doom.d/config.org" = {
    source = ../dotfiles/doom-emacs/config.org;
    onChange = updateInit;
  };

  home.file.".doom.d/meow.org" = {
    source = ../dotfiles/doom-emacs/meow.org;
    onChange = updateInit;
  };


  home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    if [ ! -d "$HOME/.doom.d" ];then
    mkdir -p $HOME/.doom.d/
    mkdir -p $HOME/.doom.d/etc
    fi

    if [ ! -d "$HOME/.doom.d/modules" ];then
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/lisp" $HOME/.doom.d/lisp
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/bin" $HOME/.doom.d/bin
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/snippets" $HOME/.doom.d/snippets
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/modules" $HOME/.doom.d/modules
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/Makefile" $HOME/.doom.d/Makefile
    fi

    if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
         mkdir -p $HOME/.doom.d/modules/private/my-org
         mkdir -p $HOME/.doom.d/modules/private/my-code
         mkdir -p $HOME/.doom.d/autoload
    fi
  '';
}
