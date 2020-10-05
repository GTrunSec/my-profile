{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [
    home-manager
  ];
  shellHook = ''
    home-manager build -f home.nix
    '';
}
