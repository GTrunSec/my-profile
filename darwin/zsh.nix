{ config, lib, pkgs, ... }:
let
    home_directory = builtins.getEnv "HOME";
in
{
  programs.zsh = {
    enable = true;
    enableCompletion = true;
    #syntaxHighlighting.enable = true;

    # shellAliases = with pkgs; {
    #   l     = "exa -lah";
    #   f     = "rg --files";
    #   E     = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
    #   em    = "emacs";
    #   cp    = "cp -i";
    #   mv    = "mv -i";
    #   overlay-go   = "cd ~/.config/nixpkgs/nixos/overlays/go";
    #   overlay-python   = "cd ~/.config/nixpkgs/nixos/overlays/python";
    #   overlay-custom   = "cd ~/.config/nixpkgs/nixos/overlays/custom";
    #   ag0   = "rg --max-depth=1";
    #   pcat  = "${python3Packages.pygments}/bin/pygmentize";
    #   so    = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
    #   si    = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
    # };
  };
}
