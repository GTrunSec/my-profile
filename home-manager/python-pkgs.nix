{ lib, pkgs, ... }:
let
  nixpkgs  = import ./misc/python-nixpkgs.nix { };
in
{
  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      home.packages = with nixpkgs;[
        (python37.buildEnv.override {
          extraLibs = with python37Packages; [
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
            # emacs eafr python dep
            shapely
            dbus-python
            qrcode
            pyqt5
            pymupdf
            xlib
            grip
            pyinotify
            pyqtwebengine
            markdown
            feedparser
            #
          ];
          ignoreCollisions = true;
        })
      ];
    })

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
            python-language-server
          ];
          ignoreCollisions = true;
        })
      ];
    })
  ];
}
