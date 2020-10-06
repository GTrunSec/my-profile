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
        #R-with-my-packages
      ] ++ [ #library
        libnotify
      ] ++ [ #misc
        #vips
        wakatime
        bat
        gron
        exa
        pet
        #emacs org notice
      ] ++ [ #haskell packages
        ##cachix use ghcide-nix
        (import ../nixos/channel/ghcide-nix {}).ghcide-ghc883
        #cachix use all-hies
        #haskellPackages.hie
      ] ++ [
        nodePackages.pyright
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
            fontspec
            euenc;
          }
          #org-mode roam-server
        )
      ];
    })
  ];

}
