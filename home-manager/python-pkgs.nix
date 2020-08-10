{ lib, pkgs, ... }:

{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      home.packages = with pkgs;[
        (python3.buildEnv.override {
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
          ];
          ignoreCollisions = true;
        })
      ];
    })
  ];
}
