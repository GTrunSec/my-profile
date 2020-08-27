{ config, lib, pkgs, ... }:
let
  overlays = [
      (import ../home-manager/packages-overlay.nix)
  ];
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs { inherit overlays; };
  clean-nix-store = nixpkgs.writeScriptBin "clean-nix-store" (import ../bin/clean-nix-store.nix { });
  stable  = import ./misc/stable-pkgs.nix { config={ allowUnfree=true; allowBroken=true; ignoreCollisions = true;};};
in
{
  config = with lib; mkMerge [

    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with stable;[
        vips
      ];
    })

    ##public pkgs
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with nixpkgs;[
        clean-nix-store
        nodePackages.node2nix
        system-sendmail
        pypi2nix
        poetry
        #vips
        nixpkgs-review
        #for emacs notdeft
        tclap
        xapian
        rnix-lsp
      ];
    })


    (mkIf pkgs.stdenv.isLinux {
      home.packages = with nixpkgs;[
        dive
      ];
    })
  ];
}
