{ config, pkgs, ... }:

{
  imports = [
    ./fonts.nix
    ./pulse.nix
    #./openvpn.nix
    #./nextcloud.nix
    #./nextcloud-mysql.nix
    #./pos.nix
    #./virtualHosts.nix
  ];
}
