{ config, lib, pkgs, ... }:


let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom sync";
  updateInit = "bash .doom.d/bin/emacs.sh";
  emacsPkg  = import ../misc/emacs-27-pkgs.nix { config={ allowUnfree=true; allowBroken=true; ignoreCollisions = true;};};
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

      programs.emacs = {
        enable = true;
        package = pkgs.emacs.overrideAttrs (old: rec {
          configureFlags = [
            "--with-librsvg"
            "--with-modules"
            "--with-ns"
            "--disable-ns-self-contained"
          ];
        });
        extraPackages = epkgs: with epkgs;[
          #undo          
          undo-tree
          undo-fu-session
          undo-fu
          #ess
          poly-markdown
          #editon
          writeroom-mode
          scrollkeeper
          #org
          #python
          flycheck-cython
          cython-mode
          pip-requirements
          poetry
          #nose
          python-pytest
          #data
          graphql-mode
          json-mode
          jsonnet-mode
          yaml-mode
          csv-mode
          dhall-mode
          protobuf-mode
          #ein
          ein
          #go
          go-eldoc
          go-guru
          go-mode
          gorepl-mode
          go-tag
          go-gen-test
          company-go
          flycheck-golangci-lint
          #latex
          ivy-bibtex
          company-auctex
          company-reftex
          company-math
          auctex
          adaptive-wrap
          latex-preview-pane
          #markdown
          markdown-mode
          markdown-toc
          edit-indirect
          grip-mode
          #helm-nixos-options
          ##vterm
          vterm
          ##
          helm-tramp
          visual-fill-column
          vlf
          wakatime-mode
          imenu-list
          eyebrowse
          cnfonts
          elfeed-org
          elfeed
          elfeed-goodies
          dimmer
          beacon
          golden-ratio
          writegood-mode
          yatemplate
          pinyin-search
          grab-x-link
          hungry-delete
          flymake-json
          bm
          w3m
          org-super-agenda
          ob-mermaid
          plantuml-mode
          ccls
          company-tabnine
          bicycle
          jsonrpc
          shrink-path
          #scheme
          geiser
          ##lsp
          company-lsp
          ##helm-lsp
          ##company-module
          company
          company-dict
          company-prescient
          #ivy
          ivy-rich
          ivy-hydra
          flx
        ];
        };
        #services.emacs.enable = true;
    })
  ];
}
