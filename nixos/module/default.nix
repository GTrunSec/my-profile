{ config, pkgs, ... }:

{
  imports = [
   ./dropbox.nix
  ];
   services.postgresql = {
    enable = true ;
    package = pkgs.postgresql_11 ;
  } ;
}
