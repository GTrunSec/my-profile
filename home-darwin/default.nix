{ lib, pkgs, ... }:

{

  imports = [
    #lang
    ./home-darwin.nix
    ./doom-emacs.nix
    ../nixos-flk/users/home-darwin.nix
    #programs
  ];


}
