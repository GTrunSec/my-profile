{ lib, pkgs, ... }:
let
  nixpkgs  = import ./misc/python-nixpkgs.nix { };
in
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        (python37.buildEnv.override {
          extraLibs = with python37Packages; [
            shapely
            matplotlib
            sqlalchemy
            pandas
            numpy
            scikitlearn
            jupyter
          ];
          ignoreCollisions = true;
        })
      ];
    })
  ];
}
