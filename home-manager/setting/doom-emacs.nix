{ config, lib, pkgs, ... }:


let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom refresh";
  updateInit = "bash .doom.d/bin/emacs.sh";
in
{
  #fonts
  home.file.".local/share/fonts/my-font" = {
    source = ../../dotfiles/my-font;
    onChange = updatefont;
  };

  home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     if [ ! -d "$HOME/.emacs.d" ];then
         ${pkgs.git}/bin/git clone https://github.com/GTrunSec/doom-emacs.git --depth=1 ~/.emacs.d
      if [ ! -d "$HOME/.emacs.d/bin/doom" ];then
       mv $HOME/.emacs.d $HOME/.emacs.d-backup
       ${pkgs.git}/bin/git clone https://github.com/GTrunSec/doom-emacs.git --depth=1 ~/.emacs.d
       fi
     fi

     if [ ! -d "$HOME/.doom.d" ];then
     mkdir -p $HOME/.doom.d/
     mkdir -p $HOME/.doom.d/autoload
     mkdir -p $HOME/.doom.d/etc
     fi

     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/lisp" $HOME/.doom.d/lisp
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/bin" $HOME/.doom.d/bin
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/snippets" $HOME/.doom.d/snippets
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/modules" $HOME/.doom.d/modules
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/Makefile" $HOME/.doom.d/Makefile

     if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
          mkdir -p $HOME/.doom.d/modules/private/my-org
          mkdir -p $HOME/.doom.d/modules/private/my-code
     fi
   '';
  # editors
  home.file.".doom.d/init.org" = {
    source = ../../dotfiles/doom/init.org;
    onChange = updateInit;
  };
  home.file.".doom.d/xah-fly.org" = {
    source = ../../dotfiles/doom/xah-fly.org;
    onChange = updateInit;
  };


  # programs.emacs = {
    # enable = true;

    # package = pkgs.emacs.overrideAttrs (old: rec {
    #   wrapperPath = with pkgs; stdenv.lib.makeBinPath ([
    #     gcc        # to compile emacsql
    #     aspell
    #     aspellDicts.en
    #     plantuml
    #     jre        # for plantuml
    #     wordnet
    #     languagetool
    #     pandoc     # markdown preview
    #   ]);
    #   postFixup = ''
    #     wrapProgram $out/bin/emacs --prefix PATH : ${wrapperPath} --set SHELL ${pkgs.bash}/bin/bash
    #   '';
    # });
    # };
}
