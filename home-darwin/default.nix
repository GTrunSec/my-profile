{ lib, pkgs, ... }:

{

  imports = [
    #lang
    ./home-darwin.nix
    ./doom-emacs.nix
    ./home-common-packages.nix
    ../nixos-flk/users/home-darwin.nix
    #programs
  ];
}
