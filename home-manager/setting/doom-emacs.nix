{ config, lib, pkgs, ... }:


let
  updatefont = ''fc-cache -f -v'';
  updateDoom = ".emacs.d/bin/doom refresh";
  updateInit = "bash .doom.d/bin/emacs.sh";
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

     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/lisp" $HOME/.doom.d/lisp
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/bin" $HOME/.doom.d/bin
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/snippets" $HOME/.doom.d/snippets
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/modules" $HOME/.doom.d/modules
     ln -sfT "${config.home.homeDirectory}/.config/nixpkgs/dotfiles/doom/Makefile" $HOME/.doom.d/Makefile

     if [ ! -d "$HOME/.doom.d/modules/my-code" ];then
          mkdir -p $HOME/.doom.d/modules/private/my-org
          mkdir -p $HOME/.doom.d/modules/private/my-code
          mkdir -p $HOME/.doom.d/modules/private/public
          mkdir -p $HOME/.doom.d/autoload
     fi
      ##modules
     ln -sfT $HOME/.emacs.d/modules/lang/haskell $HOME/.doom.d/modules/private/public/ihaskell #haskell module
     ln -sfT $HOME/.emacs.d/modules/lang/nix $HOME/.doom.d/modules/private/public/inix #nix module
     ln -sfT $HOME/.emacs.d/modules/lang/julia $HOME/.doom.d/modules/private/public/ijulia #nix module
     ##tools
     ln -sfT $HOME/.emacs.d/modules/tools/ein $HOME/.doom.d/modules/private/public/iein #ein module

     ## remove packages.el
      find -L $HOME/.doom.d/modules/private/public -mindepth 1 -name packages.el -delete
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
        programs.emacs = {
        enable = true;
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
          nose
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
          #haskell
          haskell-mode
          lsp-haskell
          #latex
          ivy-bibtex
          company-auctex
          company-reftex
          company-math
          auctex
          adaptive-wrap
          latex-preview-pane
          #julia
          julia-repl
          #markdown
          markdown-mode
          markdown-toc
          edit-indirect
          grip-mode
          #nix
          nix-mode
          nix-update
          company-nixos-options
          #helm-nixos-options
          ##vterm
          vterm
          emacs-libvterm
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
          org-starter
          org-superstar
          helm-org-rifle
          org-wild-notifier
          plantuml-mode
          ccls
          company-tabnine
          bicycle
          jsonrpc
          anzu
          doom-modeline
          shrink-path
          #scheme
          geiser
          ##lsp
          ##helm-lsp
          ##company-module
          company
          company-dict
          company-prescient
          #ivy
          ivy-rich
          ivy-hydra
          counsel
          amx
          counsel-projectile
          wgrep
          ivy-prescient
          flx
        ];
        };
        #services.emacs.enable = true;
    })
  ];
}
