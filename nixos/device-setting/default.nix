{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./pulse.nix
    ./bluetool.nix
  ];
}
