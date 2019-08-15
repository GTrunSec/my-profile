{ config, pkgs, ... }:
{
  imports = [
    ./work.nix
   ];

  home-manager.users.gtrun = {
    programs.autorandr = {
      enable = true;
    };
  };
}
