{ config, lib, pkgs, ... }:

{
  imports = [
    ./git.nix
    ./packages.nix
    #./doom-emacs.nix
    ./direnv.nix
    ./doom-emacs-pkgs.nix
    ./gpg.nix
  ];

}
