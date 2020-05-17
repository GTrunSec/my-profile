{ config, lib, pkgs, vscode-utils, ... }:
with pkgs;
let
      stable  = import ./stable.nix { config={ allowUnfree=true; allowBroken=true; ignoreCollisions = true;};};
      unstable = import (fetchTarball https://nixos.org/channels/nixos-unstable/nixexprs.tar.xz) { };
      customVscode = (import ./custom/vscode.nix { inherit pkgs; });
      customEmacs = (import ./custom/nix-emacs-ci { inherit pkgs; });
      julia = (import ./lang/julia.nix {pkgs=stable;});
      #myHaskell = (import ./custom/haskell.nix {inherit pkgs;});
      myEmacs = pkgs.emacs;
in rec
  {
    environment.systemPackages = with pkgs; [
      customEmacs.emacs_27_0          
      # KDE
      # nur.repos.ysndr.kde.breeze-blur
      # qtstyleplugin-kvantum-qt4
      # libsForQt5.qtstyleplugin-kvantum
      # qt5ct
      # latte-dock 
      # deepin.dde-dock
      #latex
      
      pet
      hugo
      desktop-file-utils
      wireshark
      (python3.withPackages (pkgs: with pkgs; [
        trezor_agent wheel
      ]))
      postgresql
      #openvpn
      (texmacs.override {chineseFonts = true; extraFonts = true;})
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
      conda
      qt5.full
      qtcreator
      #git
      git
      # (gitkraken.overrideDerivation (oldAttrs: {
      #   src = fetchurl {
      #     url = "https://release.axocdn.com/linux/GitKraken-v6.3.1.deb";
      #     sha256 = "071i3z6jym6f5nfy2mq36m45jywpk53w1vpzr2n599pabdkavj89";
      #   };
      # }))
      wget
      curl
      gnupg
      openssl
      killall
      # Browser
      chromium
      tor-browser-bundle-bin
      #firefox-bin
      # book

      xdotool
      okular
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
      nixops
      nix-index
      rustup
      rustc
      #xbacklight
      
      #overlay-package
      #JetBrains-IDE
      #jetbrains.pycharm-professional
      #jetbrains.idea-ultimate
      #jetbrains.goland
      #jetbrains.datagrip
      #jetbrains.clion
      #lang scheme
      chez
      guile
      racket
      gcc9
      #lang-haskell
      cabal2nix # create nix expressions for haskell projects from cabal file
      (import ../channel/ghcide-nix {}).ghcide-ghc865
      #lang-c++
      llvmPackages.libclang
      clang
      (ccls.overrideDerivation (oldAttrs: {
        src = fetchFromGitHub{
          owner = "MaskRay";
               repo = "ccls";
               rev = "bd609e89a29c508c8c763db2ecfad50e207391b3";
               sha256 = "18ik5rzzbwn43dd0ri518i5vzsa5ix81fpcv7gd1s6zdv3nf9bl0";
        };
      }))
      #lang-julia
      julia
      #lang-go
      go
      gotools
      go_bootstrap
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

      #screenhot
      spectacle
      #flameshot
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
