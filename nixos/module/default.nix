{ config, pkgs, ... }:

{
  imports = [
    ./dropbox.nix
    ./elk.nix
  ];
   services.postgresql = {
    enable = true ;
    package = pkgs.postgresql_11 ;
  } ;
}
