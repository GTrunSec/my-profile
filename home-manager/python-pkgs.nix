{ lib, pkgs, ... }:
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with pkgs;[
        (python37.withPackages (pkgs: with pkgs; [
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
          mypy
          python-language-server
        ]))
      ];
    })
  ];
}
