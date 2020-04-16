{ config, lib, pkgs, ... }:

{
  config = with lib; mkMerge [

    (mkIf pkgs.stdenv.isLinux {
      home.file.".config/i3/config".source = ../dotfiles/i3/config;
      home.file.".config/i3/move-cursor-window-center.sh".source = ../dotfiles/i3/move-cursor-window-center.sh;

      #polyar
      home.file.".config/polybar/config".source = ../dotfiles/polybar/config;
      home.file.".config/polybar/launch.sh".source = ../dotfiles/polybar/launch.sh;

      # compton
      home.file.".compton.conf".source = ../dotfiles/.compton.conf;
      # rofi
      home.file.".config/rofi/config".source = ../dotfiles/rofi/config;
      home.file.".config/rofi/powermenu.sh".source = ../dotfiles/rofi/powermenu.sh;
      # theme
      home.file.".config/rofi/rofi-themes/themes/arthur.rasi".source = ../dotfiles/rofi/rofi-themes/themes/arthur.rasi;
      # termite
      home.file.".config/termite/config".source = ../dotfiles/termite/config;
      # kitty
      home.file.".config/kitty/kitty.conf".source = ../dotfiles/kitty/kitty.conf;
      # Let Home Manager install and manage itself.
      #programs.home-manager.enable = true;
      # pet
      home.file.".config/pet".source = ../dotfiles/pet;
    })

    (mkIf pkgs.stdenv.isDarwin {
      home.file.".config/pet/config.toml".source = ../dotfiles/pet/darwin-config.toml;
      home.file.".config/pet/snippet.toml".source = ../dotfiles/pet/snippet.toml;
    })

    ({
      home.file.".wakatime.cfg".text = ''
    [settings]
    debug=true
    verbose = true
    offline = true
    api_key = dff3f4c8-2b39-4514-b9c7-2f3a14c928c9
    exclude = ^COMMIT_EDITMSG$
      ^TAG_EDITMSG$
      ^/var/(?!www/).*
      ^/etc/
      ^__pycache__
      ^/zeek
    include =
    include_only_with_project_file = false
    [projectmap]
    ^~/project/hardenedlinux-zeek-script/NSM-data-analysis(\d+)/ = project{0}
    ^~/.config/nixpkgs(\d+)/ = project{1}
    [git]
    disable_submodules = false
    '';
    })
    
  ];
}
