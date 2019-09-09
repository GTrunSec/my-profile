{ config, pkgs, ... }:

with builtins;

{
  # Use local nixpkgs checkout
  # The first time, might have to run:
  # nixos-rebuild -I nixpkgs=/etc/nixos/nixpkgs -I nixos-config=/etc/nixos/configuration.nix switch
  nix.nixPath = [
    
    "nixpkgs=/etc/nixos/nixpkgs"
    "nixos-config=/etc/nixos/configuration.nix"
    "nixpkgs-overlays=/etc/nixos/overlays-compat/"
  ];
  nixpkgs.config.allowUnfree = true;
  nixpkgs.overlays = [
    (import ./overlays/youtube-dl.nix)
    (import ./overlays/python/01-yapf.nix)
    (import ./overlays/python/02-ms-pyls.nix)
#    (import ./overlays/python/03-bat.nix)
    (import ./overlays/python/04-test.nix)
    (import ./overlays)
    # (self: super:
    #   {
    #     bat = super.callPackage ./overlays/python/bat{ };
    #   }
    # )
  ];
}
