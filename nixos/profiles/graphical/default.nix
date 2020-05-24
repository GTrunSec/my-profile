{ config, pkgs, ... }:
let inherit (builtins) readFile;
    slim-theme = pkgs.fetchFromGitHub {
      owner = "ezemtsov";
      repo = "slim-theme";
      rev = "aa29ec80b550c709e3c5be14066e9c25948adf38";
      sha256 = "13xx75fcaqvwi5r3cb1cr928wh79h95cx606xmrmsvjb3bqjwwd2";
    };

in {
  imports = [ ./sway #
            #  ../develop
            ];

  hardware.opengl.enable = true;
  hardware.opengl.driSupport = true;
  hardware.pulseaudio.enable = true;

  environment = {
    etc = {
      "xdg/gtk-3.0/settings.ini" = {
        text = ''
            [ Settings ]
            gtk-icon-theme-name=Papirus-Adapta
          gtk-theme-name=Adapta
          gtk-cursor-theme-name=Adwaita
        '';
        mode = "444";
      };
    };

    sessionVariables = {
      # Theme settings
      QT_QPA_PLATFORMTHEME = "gtk2";
      GTK2_RC_FILES = let
        gtk = ''
          gtk-icon-theme-name="Papirus-Adapta"
          gtk-cursor-theme-name="Adwaita"
        '';
      in [
        ("${pkgs.writeText "iconrc" "${gtk}"}")
        "${pkgs.adapta-gtk-theme}/share/themes/Adapta/gtk-2.0/gtkrc"
        "${pkgs.gnome3.gnome-themes-extra}/share/themes/Adwaita/gtk-2.0/gtkrc"
      ];
    };

    systemPackages = with pkgs; [
      adapta-gtk-theme
      cursor
      dzen2
      feh
      ffmpeg-full
      firefox
      gnome3.adwaita-icon-theme
      gnome-themes-extra
      imagemagick
      imlib2
      librsvg
      libsForQt5.qtstyleplugins
      papirus-icon-theme
      sddm-chili
      zathura
    ];
  };

  services.xserver = {
    enable = true;    
    layout = "us";

    videoDrivers = [ "nvidia" "intel"];

    desktopManager.plasma5.enable = true;

    displayManager.sddm = {
      enable = true;
      theme = "chili";
      # autoLogin = {
      #   enable = true;
      #   user = "gtrun";
      # };
    };
  };

  # hardware.nvidia.prime.enable = true;
  # Bus ID of the NVIDIA GPU. You can find it using lspci

  hardware.nvidia.prime.nvidiaBusId = "PCI:1:0:0";
  hardware.nvidia.prime.intelBusId= "PCI:0:2:0";
  boot.blacklistedKernelModules = [ "nouveau" ];
}
