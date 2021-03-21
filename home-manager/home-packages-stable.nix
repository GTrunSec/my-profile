{ lib, pkgs, ... }:
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with pkgs;[
        (texlive.combine
          {
            inherit (texlive)
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
        vips
      ] ++ [
        (python3.withPackages (pkgs: with pkgs; [
          shapely
          sqlalchemy
          pandas
          numpy
          mypy
        ] ++ [
        ]))
      ];
    })
  ];
}
