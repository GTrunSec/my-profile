{ config, lib, pkgs, ... }:
let
  clean-nix-store = pkgs.writeScriptBin "clean-nix-store" (import ../bin/clean-nix-store.nix { });
in
{
  config = with lib; mkMerge [
    ##public pkgs
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with pkgs;[
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
        #rnix-lsp
      ];
    })

    (mkIf pkgs.stdenv.isLinux {
      home.packages = with pkgs;[
        dive
        gpg
        #python37Packages.voila
      ];
    })
  ];
}
