{ config, pkgs, lib, ... }:

let
  
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";

in

{
  
  imports = [
    ./home-manager/import.nix
    ./home-manager/randr
    ~/.nix-defexpr/channels/home-manager/modules/services/emacs.nix
  ];

  config = with lib; mkMerge [
    ({
      programs.direnv = {
        enable = true;
        enableBashIntegration = true;
        enableZshIntegration = true;
      };


      programs.gpg = {
        enable = true;
        settings = {
          default-key = "6A43333DBD6C7C70B7A1DB59761C8EBEA940960E";
          cert-digest-algo = "SHA512";
          disable-cipher-algo = "3DES";
          default-recipient-self = true;
          use-agent = true;
          with-fingerprint = true;
        };
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
      services.gpg-agent ={
        defaultCacheTtl = 180000;
        defaultCacheTtlSsh = 180000;
        enable = true;
        enableScDaemon = true;
        enableSshSupport = true;
        grabKeyboardAndMouse = false;
      };

        services.dunst = {
          enable = true;
        };
    })

    (mkIf pkgs.stdenv.isDarwin {
      home.file.".gnupg/gpg-agent.conf".text = ''
        enable-ssh-support
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    })
    
    (mkIf pkgs.stdenv.isLinux {
      systemd.user.startServices = true;
      services.emacs.enable = true;
    })

  ];
}
