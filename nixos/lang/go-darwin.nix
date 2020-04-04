{ config, lib, pkgs, ... }:
with pkgs;
let
  deepsea = pkgs.callPackage  ~/.config/nixpkgs/nixos/overlays/go/deepsea {};
in

{
  environment.systemPackages = with pkgs; [
    deepsea
    gocode
    go-langserver
    gotools
    ];
}
