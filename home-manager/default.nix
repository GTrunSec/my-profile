{ lib, pkgs, ... }:

{

  imports = [
    ./setting
    #lang
    ./home-packages-stable.nix
    ./my3rd-scripts.nix
    ./home-files.nix
    ./home-darwin.nix
    ./programs
    ./home-common-packages.nix
    ./shell-env.nix
    #programs
  ];
}
