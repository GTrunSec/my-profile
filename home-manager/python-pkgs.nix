{ lib, pkgs, ... }:
let
  nixpkgs  = import ./misc/python-nixpkgs.nix { };
in
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      home.packages = with nixpkgs;[
        (python37.buildEnv.override {
          extraLibs = with python3Packages; [
            pytest
            numpy
            #orgparse
            pytest
            scikitlearn
            #zat
            matplotlib
            sqlalchemy
            pandas
            #voila
            python-language-server
            pygments
            #orgbabelhelper
            wakatime
            jupyter
            jupyterlab
          ];
          ignoreCollisions = true;
        })
      ];
    })

    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        (python37.buildEnv.override {
          extraLibs = with python3Packages; [
          shapely
          matplotlib
          sqlalchemy
          pandas
          numpy
          scikitlearn
          jupyter
          python-language-server
          ];
          ignoreCollisions = true;
        })
      ];
    })
  ];
}
