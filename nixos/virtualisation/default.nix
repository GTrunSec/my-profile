{ config, pkgs, ... }:

{
  imports = [
    ./docker.nix
    #./libvirtd.nix
    ./vbox.nix
  ];
}
