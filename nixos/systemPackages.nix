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

      #
      dotnet-sdk
  ];
  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
  
}
