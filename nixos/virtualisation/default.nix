{ config, pkgs, ... }:

{
  imports = [
    ./docker.nix
    ./libvirtd.nix
  ];
}
