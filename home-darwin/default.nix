{ lib, pkgs, ... }:

{

  imports = [
    #lang
    ./home-darwin.nix
    ./doom-emacs.nix
    ./darwin-git.nix
    ../nixos-flk/users/home-darwin.nix
    #programs
  ];


}
