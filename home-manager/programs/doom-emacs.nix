{ config, lib, pkgs, ... }:
let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom sync";
  updateInit = "bash .doom.d/bin/emacs.sh";
  emacsDrawin-overlay = import ./nix-gcc-emacs-darwin/emacs.nix;
  overlays = [
    emacsDrawin-overlay
    (import (builtins.fetchTarball {
      url = https://github.com/nix-community/emacs-overlay/archive/master.tar.gz;
    }))
  ];
  emacsPkgs  = import ../misc/emacs-27-pkgs.nix { inherit overlays;};
in
{
  config = with lib; mkMerge [
    #fonts
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.file.".local/share/fonts/my-font" = {
        source = ../../dotfiles/my-font;
        onChange = updatefont;
      };

      home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     if [ ! -d "$HOME/.emacs.d" ];then
         ${pkgs.git}/bin/git clone https://github.com/GTrunSec/doom-emacs.git -b my-doom --depth=1 ~/.emacs.d
      if [ ! -d "$HOME/.emacs.d/bin/doom" ];then
       mv $HOME/.emacs.d $HOME/.emacs.d-backup
       ${pkgs.git}/bin/git clone https://github.com/GTrunSec/doom-emacs.git -b my-doom --depth=1 ~/.emacs.d
       fi
     fi

     if [ ! -d "$HOME/.doom.d" ];then
     mkdir -p $HOME/.doom.d/
     mkdir -p $HOME/.doom.d/etc
     fi

     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/lisp" $HOME/.doom.d/lisp
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/bin" $HOME/.doom.d/bin
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/snippets" $HOME/.doom.d/snippets
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/modules" $HOME/.doom.d/modules
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom-emacs/Makefile" $HOME/.doom.d/Makefile

     if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
          mkdir -p $HOME/.doom.d/modules/private/my-org
          mkdir -p $HOME/.doom.d/modules/private/my-code
          mkdir -p $HOME/.doom.d/autoload
     fi
   '';
      # editors
      home.file.".doom.d/config.org" = {
        source = ../../dotfiles/doom-emacs/config.org;
        onChange = updateInit;
      };
      home.file.".doom.d/xah-fly.org" = {
        source = ../../dotfiles/doom-emacs/xah-fly.org;
        onChange = updateDoom;
      };
    })

    
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      programs.emacs.enable = true;
    })


    (mkIf pkgs.stdenv.isDarwin {
      programs.emacs.package = emacsPkgs.emacsGccDarwin;
    })

    (mkIf pkgs.stdenv.isLinux {
      programs.emacs.package = (emacsPkgs.emacsGcc.override({
          imagemagick = emacsPkgs.imagemagickBig;
      })).overrideAttrs(old: rec {
        configureFlags = (old.configureFlags or []) ++ ["--with-imagemagick"
                                                        "--with-nativecomp"
                                                       ];
      });
    })

    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
        programs.emacs.extraPackages = epkgs: with epkgs;[
          vterm
        ];
    })


    (mkIf pkgs.stdenv.isLinux {
        programs.emacs.extraPackages = epkgs: with epkgs;[
          grab-x-link
        ];
    })
      #services.emacs.enable = true;
  ];
}
