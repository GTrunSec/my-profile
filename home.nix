{ config, pkgs, lib, ... }:

let
  
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";

in

{
  
  imports = [
    ./home-manager/import.nix
    ./home-manager/randr
  ];

  config = with lib; mkMerge [
    ({
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };


      programs.fzf = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };

      programs.home-manager = {
        enable = true;
        path = "${home_directory}/.nix-defexpr/channels/home-mananger";
      };

      home.sessionVariables = {
      };
    })

    (mkIf pkgs.stdenv.isLinux {
      systemd.user.startServices = true;
    })

  ];
}
