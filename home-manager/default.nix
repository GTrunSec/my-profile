{ lib, pkgs, ... }:

{

  imports = [
    ./setting
    #lang
    ./home-package.nix
    ./my3rd-scripts.nix
    ./home-files.nix
    ./home-darwin.nix
    ./misc
    ./programs
    ./python-pkgs.nix
    ./shell-env.nix
    #programs
  ];
}
