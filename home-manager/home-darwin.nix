{ config, lib, pkgs, ... }:
let

  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  my-pkgs = pkgs.fetchFromGitHub {
    owner = "hardenedlinux";
    repo = "NSM-data-analysis";
    rev = "1bc6bc22c63c034d272150a26d74b149cc677ab8";
    sha256 = "18yrwg6xyhwmf02l6j7rcmqyckfqg0xy3nx4lcf6lbhc16mfncnf";
  };

  juliaEnv = (import "${my-pkgs}/pkgs/julia-non-cuda.nix" {});
in

{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        (python3.withPackages (pkgs: with pkgs; [
          shapely
          matplotlib
          sqlalchemy
          pandas
          numpy
          scikitlearn
        ]))
        #vips
        ##cachix use ghcide-nix
        (import ../channel/ghcide-nix {}).ghcide-ghc865
        bat
        gron
        (all-hies.unstable.selection { selector = p: { inherit (p) ghc865; }; })
        exa
        pet
        vscode
        juliaEnv
        (texlive.combine # latex + packages
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
            fontspec euenc;
          }
        )
      ];
    })
  ];

}
