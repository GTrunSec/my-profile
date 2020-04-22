{ config, lib, pkgs, ... }:
let

  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

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

        ##cachix use ghcide-nix
        (import ../channel/ghcide-nix {}).ghcide-ghc865
        bat
        gron
        (all-hies.unstable.selection { selector = p: { inherit (p) ghc865; }; })
        exa
        pet
        vscode
      ];
    })
  ];

}
