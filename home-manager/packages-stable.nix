{ lib, pkgs, ... }:
let
  overlays = [
    (import ../nixos-flk/pkgs/default.nix)
  ];

  nixpkgs  = import ./misc/stable-pkgs.nix { inherit overlays; };

in
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[
        vips
      ] ++ [
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
          mypy
        ] ++ [
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
          )
        ]))
      ];
    })
  ];
}
