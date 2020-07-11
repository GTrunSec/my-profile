{ config, lib, pkgs, ... }:
let

  nixpkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};
  my-pkgs = pkgs.fetchFromGitHub {
    owner = "hardenedlinux";
    repo = "NSM-data-analysis";
    rev = "1bc6bc22c63c034d272150a26d74b149cc677ab8";
    sha256 = "18yrwg6xyhwmf02l6j7rcmqyckfqg0xy3nx4lcf6lbhc16mfncnf";
  };

  juliaEnv = (import "${my-pkgs}/pkgs/julia-non-cuda.nix" {});
  customVscode = (import ../nixos/custom/vscode.nix { inherit pkgs; });

  R-with-my-packages = nixpkgs.rWrapper.override{
    packages = with nixpkgs.rPackages; [ ggplot2 dplyr xts ]; };
in

{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        customVscode
        #R-with-my-packages
        (python3.withPackages (pkgs: with pkgs; [
          shapely
          matplotlib
          sqlalchemy
          pandas
          numpy
          scikitlearn
          # (pylint.overridePythonAttrs (oldAttrs: {
          #     src = fetchPypi {
          #       pname = "pylint";
          #       version = "2.5.2";
          #       sha256 = "1344f6zrv3airdls19pbqs7vrb2ky0r09m1y53167w9s1y2k2pmr";
          #     };
          # }))
        ]))
        #vips
        ##cachix use ghcide-nix
        (import ../nixos/channel/ghcide-nix {}).ghcide-ghc865
        bat
        gron
        (all-hies.unstable.selection { selector = p: { inherit (p) ghc865; }; })
        exa
        pet
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
            fontspec
            euenc;
          }
          #org-mode roam-server
        )
      ];
    })
  ];

}
