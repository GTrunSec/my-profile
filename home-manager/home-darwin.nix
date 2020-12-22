{ config, lib, pkgs, ... }:
let
  customVscode = (import ../nixos-flk/profiles/code/vscode.nix { inherit pkgs; });

  R-with-my-packages = pkgs.rWrapper.override{
    packages = with pkgs.rPackages; [ ggplot2 dplyr xts ]; };
in

{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with pkgs;[
        customVscode
        nixFlakes
        #R-with-my-packages
      ] ++ [ #library
        libnotify
      ] ++ [ #misc
        git
        fd
        reattach-to-user-namespace
        ispell
        hunspell
        wakatime
        bat
        gron
        exa
        pet
        ripgrep
        ag
        gitAndTools.delta
        (bundler.overrideAttrs(old:  {
          name = "bundler-2.1.4";
          src = pkgs.fetchurl {
            url = "https://rubygems.org/gems/bundler-2.1.4.gem";
            sha256 = "12glbb1357x91fvd004jgkw7ihlkpc9dwr349pd7j83isqhls0ah";
          };
          postFixup = ''
          mv $out/bin/bundle $out/bin/ruby-bundle
          sed -i -e "s/activate_bin_path/bin_path/g" $out/bin/ruby-bundle
            '';
        }))
        jekyll
        #emacs org notice
      ] ++ [ #haskell packages
        ##cachix use ghcide-nix
        #cachix use all-hies
        #haskellPackages.hie
        haskellPackages.haskell-language-server
        haskellPackages.ghc
      ] ++ [
        graphviz
        nodePackages.pyright
        nodePackages.mathjax-node-cli
        nodePackages.mathjax
      ] ++ [ #go packages
        govet
        gocode
        gopls
        hugo
      ] ++ [  # latex + packages
        (texlive.combine
          { inherit (texlive)
            collection-plaingeneric
            collection-latexextra
            collection-fontsrecommended
            collection-pictures
            collection-bibtexextra
            collection-mathscience
            collection-langgerman
            scheme-basic
            xetex
            cjk
            ctex
            xecjk
            dvipng
            fontspec
            euenc;
          }
          #org-mode roam-server
        )
      ];
    })
  ];

}
