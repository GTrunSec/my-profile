{ config, lib, pkgs, ... }:
{
  imports = [
    ./alacritty
    ./git.nix
    ./tmux.nix
    ./doom-emacs.nix
    ./zsh.nix
  ];



  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isLinux {
      programs.htop.enable = true;
      programs.bat.enable = true;
    })
  ];
}
