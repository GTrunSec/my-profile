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
      wireshark
      (python3.withPackages (pkgs: with pkgs; [
        trezor_agent wheel
      ]))
      postgresql
      #openvpn
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
      conda
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
          url = "https://github.com/burtonator/polar-bookshelf/releases/download/v1.40.1/polar-bookshelf-1.40.1-amd64.deb";
          sha256 = "1gbhh7h1q09dy6f8f91zdplv5a64kgpdywlnzzry51i1ilgdq009";
        };
      }))
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

      cargo
      rustup
      rustc
      #xbacklight
      
      #overlay-package
      #zeek
      #JetBrains-IDE
      #jetbrains.pycharm-professional
      #jetbrains.idea-ultimate
      #jetbrains.goland
      #jetbrains.datagrip
      #jetbrains.clion
      #lang-haskell
      cabal2nix # create nix expressions for haskell projects from cabal file
      #lang-c++
      llvmPackages.libclang
      clang
      (ccls.overrideDerivation (oldAttrs: {
        src = fetchFromGitHub{
          owner = "MaskRay";
               repo = "ccls";
               rev = "eeda2882f313fd7e19a969e68544944041e44cae";
               sha256 = "1rnr5cgm2v15gllazl9zrsbbg6kv6j22fivvmf4ibbzwl18g6sis";
        };
      }))
      gcc
      #lang-julia
      # (julia.overrideDerivation (oldAttrs: {
      #   src = fetchzip{
      #   url = "https://github.com/JuliaLang/julia/releases/download/v1.3.0-rc4/julia-1.3.0-rc4.tar.gz";
      #   sha256 = "15r0mhdrg9cvkm1jxyyxqnxj7q3k7zr92h8lfsb06abkflr8x59z";
      #   };
      # }))
      julia_11
      #lang-go
      gotools
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
