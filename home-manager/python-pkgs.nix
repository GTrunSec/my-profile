{ lib, pkgs, ... }:
let

  overlays = [ (import ../nixos-flk/overlays/pkgs.nix)
             ];

  nixpkgs  = import ./misc/python-nixpkgs.nix { inherit overlays; };
in
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        (python37.withPackages (nixpkgs: with nixpkgs; [
          shapely
          matplotlib
          sqlalchemy
          pandas
          numpy
          scikitlearn
          jupyter
          promnesia
          orgparse
          hpi
        ]))
      ];
    })
  ];
}
