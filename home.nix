{ config, pkgs, ... }:

let
  
  home_directory = builtins.getEnv "HOME";
  log_directory = "${home_directory}/logs";

in

{
  
  imports = [
    ./home-manager/import.nix
  ];

    
  programs.autorandr = {
    enable = true;
  };


  # i3-gaps
  home.file.".config/i3/config".source = ./dotfiles/i3/config;
  home.file.".config/i3/move-cursor-window-center.sh".source = ./dotfiles/i3/move-cursor-window-center.sh;

  #polyar
  home.file.".config/polybar/config".source = ./dotfiles/polybar/config;
  home.file.".config/polybar/launch.sh".source = ./dotfiles/polybar/launch.sh;
  
  # compton
  home.file.".compton.conf".source = ./dotfiles/.compton.conf;
  # rofi
  home.file.".config/rofi/config".source = ./dotfiles/rofi/config;
  home.file.".config/rofi/powermenu.sh".source = ./dotfiles/rofi/powermenu.sh;
  # theme
  home.file.".config/rofi/rofi-themes/themes/arthur.rasi".source = ./dotfiles/rofi/rofi-themes/themes/arthur.rasi;
  # termite
  home.file.".config/termite/config".source = ./dotfiles/termite/config;
  # kitty
  home.file.".config/kitty/kitty.conf".source = ./dotfiles/kitty/kitty.conf;
  # Let Home Manager install and manage itself.
  #programs.home-manager.enable = true;

}
