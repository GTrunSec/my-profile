{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./pulse.nix
    #./nextcloud.nix
    #./nextcloud-mysql.nix
    #./pos.nix
    #./virtualHosts.nix
  ];
}
