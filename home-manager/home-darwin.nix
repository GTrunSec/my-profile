{ config, lib, pkgs, ... }:
let
  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };

in

{

  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {

      home.packages = with nixpkgs;[
        bat
      ];


    })
  ];

}
