{ pkgs ? import <nixpkgs> {} }:

with pkgs;

mkShell {
  buildInputs = [

  ];
  shellHook = ''
    home-manager build -f home.nix
    '';
}
