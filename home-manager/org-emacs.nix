{ config, lib, pkgs, ... }:


let updateEmacs = ''bash .emacs.d/bin/emacs.sh'';

in
{
  # editors
  home.file.".emacs.d/init.org" = {
    source = ../dotfiles/emacs/emacs.d/init.org;
    onChange = updateEmacs;
  };
  home.file.".emacs.d/Makefile".source = ../dotfiles/emacs/emacs.d/Makefile;
  #pyrime
   home.file.".emacs.d/pyim".source = ../dotfiles/emacs/emacs.d/pyim;
    home.activation.linkEmacsLisp = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/emacs/emacs.d/lisp" $HOME/.emacs.d/lisp
  '';
    home.activation.linkEmacsBin = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/emacs/emacs.d/bin" $HOME/.emacs.d/bin
  '';

   home.activation.linkEmacsPrivate = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/emacs/emacs.d/private" $HOME/.emacs.d/private
  '';
      home.activation.linkEmacsSetup = config.lib.dag.entryAfter [ "writeBoundary" ] ''
    ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/emacs/emacs.d/setup" $HOME/.emacs.d/setup
  '';
    programs.emacs = {
    enable = true;

    package = pkgs.emacs.overrideAttrs (old: rec {
      wrapperPath = with pkgs; stdenv.lib.makeBinPath ([
        gcc        # to compile emacsql
        aspell
        aspellDicts.en
        plantuml
        jre        # for plantuml
        wordnet
        languagetool
        pandoc     # markdown preview
      ]);
      postFixup = ''
        wrapProgram $out/bin/emacs --prefix PATH : ${wrapperPath} --set SHELL ${pkgs.bash}/bin/bash
      '';
    });
    };
}
