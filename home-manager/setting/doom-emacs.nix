{ config, lib, pkgs, ... }:


let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom refresh";
  updateInit = "bash .doom.d/bin/emacs.sh
             .emacs.d/bin/doom refresh";
in
{
  #fonts
    home.file.".local/share/fonts/my-font" = {
    source = ../../dotfiles/my-font;
    onChange = updatefont;
  };

    # editors
    home.file.".doom.d/init.org" = {
      source = ../../dotfiles/doom/init.org;
      onChange = updateInit;
    };
    home.file.".doom.d/Makefile".source = ../../dotfiles/doom/Makefile;
    home.activation.linkEmacsLisp = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/lisp" $HOME/.doom.d/lisp
   '';
    home.activation.linkEmacsBin = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/bin" $HOME/.doom.d/bin
   '';

    home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/modules" $HOME/.doom.d/modules
   '';
    #     home.activation.linkEmacsSetup = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    #   ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/emacs/emacs.d/setup" $HOME/.emacs.d/setup
    # '';


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
