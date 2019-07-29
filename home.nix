{ config, pkgs, ... }:

let
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";
  clean-nix-store = pkgs.writeShellScriptBin "clean-nix-store" ./bin/clean-nix-store;
in
{
  nixpkgs = {
    config = {
      allowUnfree = true;
      allowBroken = false;
      allowUnsupportedSystem = false;
    };

  };


    imports = [
      ./org-emacs.nix
      ./git.nix
    ];


  home.packages = with pkgs; [
   xclip
   urxvt_perls
   ag
   graphviz
   rofi
   termite
   i3-gaps
   xdotool
   compton
   fish
  ];



  #fish
  programs.direnv.enable = true;
  programs.fish = {
    enable = true;
    shellAliases = with pkgs; {
      l = "exa -lah";
      f = "rg --files";
      pcat = "${python3Packages.pygments}/bin/pygmentize";
      so = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*usb/{if (a != \"\") print a;} {a=$NF}\\\')";
      si = "pactl set-default-sink (pacmd list-sinks | awk \\\'/name:.*pci/{if (a != \"\") print a;} {a=$NF}\\\')";
    };
  };

  home.file.".config/fish/functions/hs.fish".source = ./dotfiles/fish/functions/hs.fish;

  # i3-gaps
  home.file.".config/i3/config".source = ./dotfiles/i3/config;
  home.file.".config/i3/move-cursor-window-center.sh".source = ./dotfiles/i3/move-cursor-window-center.sh;

  #polyar
  home.file.".config/polybar/config".source = ./dotfiles/polybar/config;
  home.file.".config/polybar/launch.sh".source = ./dotfiles/polybar/launch.sh;
  #home.file.".config/polybar/pkg.sh".source = ./dotfiles/polybar/pkg.sh;


  # compton
  home.file."~/.compton.conf".source = ./dotfiles/.compton.conf;
  # rofi
  home.file.".config/rofi/config".source = ./dotfiles/rofi/config;
  home.file.".config/rofi/powermenu.sh".source = ./dotfiles/rofi/powermenu.sh;
  # theme
  home.file.".config/rofi/rofi-themes/themes/arthur.rasi".source = ./dotfiles/rofi/rofi-themes/themes/arthur.rasi;
  # termite
  home.file.".config/termite/config".source = ./dotfiles/termite/config;

# Let Home Manager install and manage itself.
  programs.home-manager.enable = true;

}
