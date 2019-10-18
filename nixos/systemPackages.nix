{ config, lib, pkgs, vscode-utils, ... }:
with pkgs;

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
      #latex
      texmacs
      ( texlive.combine # latex + packages
        { inherit (texlive)
          collection-plaingeneric
          collection-latexextra
          collection-fontsrecommended
          collection-pictures
          collection-bibtexextra
          collection-mathscience
          collection-langgerman
          scheme-basic
          xetex
          cjk
          ctex
          xecjk
          fontspec euenc;
          
        }
      )
      emacs
      ispell
      dropbox
      texlive.combined.scheme-basic
      jupyter
      lxappearance
      appimage-run
      #wmctrl
      glxinfo

      customVscode
      w3m
      polybar
      cmake
      home-manager
      gnumake

      #git
      git
      (gitkraken.overrideDerivation (oldAttrs: {
        src = fetchurl {
          url = "https://release.axocdn.com/linux/GitKraken-v6.3.0.deb";
          sha256 = "06hjzkkrg2f9lb72ik16zgv813cxsv679szfdzrfygbb6wxnkjyp";
        };
      }))
      wget
      curl
      gnupg
      openssl
      killall
      # Browser
      # chromium
      tor-browser-bundle-bin
      firefox-bin
      flashplayer
      # book
      (polar-bookshelf.overrideDerivation (oldAttrs: {
        src = fetchurl {
          url = "https://github.com/burtonator/polar-bookshelf/releases/download/v1.32.48/polar-bookshelf-1.32.48-amd64.deb";
          sha256 = "1x4ls0vhkswzljyvqi59g75blmqah1dnz592ai5ydignh3l8vlj4";
        };
      }))
      xdotool

      #password
      enpass

      # graph
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
      #JetBrains-IDE
      jetbrains.pycharm-professional
      #jetbrains.idea-ultimate
      jetbrains.goland
      jetbrains.datagrip
      jetbrains.clion
      #lang-haskell
      cabal2nix # create nix expressions for haskell projects from cabal file
      #lang-c++
      ccls  
      #lang-go
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
