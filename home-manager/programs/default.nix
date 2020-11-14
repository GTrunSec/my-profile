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

    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      programs.broot.enable = true;
    })
  ];
}
