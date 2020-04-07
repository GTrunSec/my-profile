{ config, lib, pkgs, ... }:
let
  darwin = (import <nix-darwin> { config.allowUnfree = true; config.ignoreCollisions = true;});
in
{
  environment.systemPackages = with darwin; [
    emacs
  ];
}
