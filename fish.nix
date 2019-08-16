{ config, pkgs, ... }:

{


  #fish
  programs.direnv.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      l = "exa -lah";
      f = "rg --files";
      E = "env SUDO_EDITOR=\"emacsclient\" sudo -e";
      pcat = "${python3Packages.pygments}/bin/pygmentize";
      so = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
      si = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
    };
  };

  
  home.file.".config/fish/functions/hs.fish".source = ./dotfiles/fish/functions/hs.fish;

}
