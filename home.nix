{ config, pkgs, lib, ... }:
let
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";
  all-hies = (fetchTarball "https://github.com/infinisil/all-hies/tarball/534ac517b386821b787d1edbd855b9966d0c0775");
  emacs-overlay-rev = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.emacs-overlay.locked.rev;
in
{
  imports = [
    ./home-darwin
  ];


  config = with lib; mkMerge [
    ({

      nixpkgs.overlays = [
        #(import ./nixos-flk/pkgs/default.nix)
        (import ./nixos-flk/overlays/node-packages-overlay.nix)
        (import (builtins.fetchTarball {
          url = "https://github.com/nix-community/emacs-overlay/archive/${emacs-overlay-rev}.tar.gz";
        }))
      ];

    })

    (mkIf pkgs.stdenv.isDarwin {

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
      home.sessionVariables = { };

      home.file.".gnupg/gpg-agent.conf".text = ''
        enable-ssh-support
        pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
      '';
    })
  ];
}
