{ config, lib, pkgs, vscode-utils, ... }:
let
  customVscode = (import ./custom/vscode.nix { inherit pkgs; });
  customEmacs = (import ./custom/nix-emacs-ci { inherit pkgs; });
  myEmacs = pkgs.emacs;
in rec
  
  {
    hardware.brightnessctl.enable = true;
    environment.systemPackages = with pkgs; [
      #customEmacs.emacs_26_3
      # nur
      # KDE
      # nur.repos.ysndr.kde.breeze-blur
      # qtstyleplugin-kvantum-qt4
      # libsForQt5.qtstyleplugin-kvantum
      # qt5ct
      # latte-dock
      # deepin.dde-dock
      lxappearance
      #wmctrl
      glxinfo
      emacs
      customVscode
      w3m
      fantasque-sans-mono
      polybar
      cmake
      home-manager
      gnumake
      git
      wget
      curl
      gnupg
      openssl
      killall
      chromium
      polar-bookshelf
      xdotool
      enpass
      ditaa
      graphviz
      #terminal
      kitty
      # Unzip
      p7zip
      unzip
      zip
      pciutils    # lspci
      psmisc      # pkill, killall, pstree, fuser
      # rime
      librime
      fcitx-configtool
      #
      goldendict
      #
      qt5.qtbase
      #xdgrm
      virtmanager

      cargo
      rustup
      rustc
      #xbacklight
      
      #overlay-package
      #zeek
      #lang
      go
      go-langserver
      gocode
      go-outline
      go-symbols
      go2nix
      go-tools
      gocode-gomod
      godef
      gopkgs
      delve
      golint

      #remote
      rxvt_unicode.terminfo

      ncurses.dev # infocmp/tic/etc
      spectacle

      mpv
      rocksdb
      #
      dotnet-sdk
      #libraries
      caf
  ];
    environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };

  #   environment.etc."".source = pkgs.runCommandNoCC "lvm.conf" {} ''
  #   sed ${pkgs.lvm2}/etc/lvm.conf -e "s/issue_discards = 0/issue_discards = 1/" > $out
  # '';
  
}
