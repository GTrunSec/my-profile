let
  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };
  remacs = (import ./programs/remacs-nix/build.nix) {};
  unstable = import <nixpkgs-unstable> { };

  ownpkgs_git = builtins.fetchTarball {
    url    = "https://github.com/GTrunSec/nixpkgs-channels/tarball/60e1709baefb8498103d598ca4f14ac39719d448";
    sha256 = "15vsi0k65vjmr57jdjihad1yx0d8i83xnc0v7fpymgrwldvjblx4";
  };

  ownpkgs = (import ownpkgs_git) { };

in   {
  home.packages = with nixpkgs;[
    #remacs
    aria2
    xclip
    screenfetch
    urxvt_perls
    ag
    hunspell
    gitkraken
    #dnsproxy
    # tags your files
    tmsu
    graphviz
    rofi
    pkgs.pandoc
    fd
    ripgrep
    feh
    lsof
    lm_sensors
    #image
    gimp
    #brower
    (brave.overrideDerivation (oldAttrs: {
      src = fetchurl {
        url = "https://github.com/brave/brave-browser/releases/download/v1.5.115/brave-browser_1.5.115_amd64.deb";
        sha256 = "04zyv5amqxax1z0da4bcgxwsq596zfs416nshg6ffg4ci9nfbiab";
      };
    }))
    #chat
    riot-desktop
    (signal-desktop.overrideDerivation (oldAttrs: {
      src = fetchurl {
        url = "https://updates.signal.org/desktop/apt/pool/main/s/signal-desktop/signal-desktop_1.32.1_amd64.deb";
        sha256 = "0sfzz1z57l20prj2s8hdl8ip1hrlzb5fqnccqcfd101a6mjnp9i9";
      };
    }))
    #gitter
    #msusic
    cmus
    compton
    discord
    #skim
    screenfetch
    (polar-bookshelf.overrideDerivation (oldAttrs: {
      src = fetchurl {
        url = "https://github.com/burtonator/polar-bookshelf/releases/download/v1.90.18/polar-bookshelf-1.90.18-amd64.deb";
        sha256 = "1yl679szhb38a4dkb0aviyyp5qi7sc5vxhpjrrzzkrbzqrgnx1x2";
      };
    }))
    #overlay
    outline-client
    youtube-dl
    shadowsocks-qt5
    sshfs
    ms-pyls
    #nur
    imgcat

    #haskell
    haskellPackages.hlint
    haskellPackages.hoogle
    cabal-install
    #(haskell.lib.dontCheck haskellPackages.intero)
    haskellPackages.alex
    haskellPackages.happy
    haskellPackages.zlib
    #haskellPackages.stack

    haskellPackages.stylish-haskell
    #multi-ghc-travis
    niv
    #downloader
    motrix
    #adguardhome
    #log database
    #vast
    #(import (builtins.fetchTarball "https://github.com/tenzir/vast/tarball/924b05aadaad113a827fa3126bc30b2a9603baa5"){})
    tree
    vgo2nix
    #emacs eaf
    lxqt.qtermwidget

    deepsea
    libvterm
    libtool

    #emacsPackages
    (emacsPackages.emacsWithPackages (with pkgs.emacsPackagesNg; [
    emacs-libvterm
    ]))

    (python3.withPackages (pkgs: with pkgs; [
      shapely
      # eaf
      dbus
      qrcode
      pyqt5
      pymupdf
      xlib
      grip
      pyinotify
      pyqtwebengine
      markdown
      feedparser
      ##
      pytest
      numpy
      orgparse
      jupyter_core
      #ipynb-py-convert
      scikitlearn
      zat
      matplotlib
      sqlalchemy
      pandas
      ipython
      python-language-server
      pygments
      notebook
      orgbabelhelper
      ipykernel
    ]))

    #Go
    horcrux
    zeek
    rocksdb
    sqlite
    fish-foreign-env
    pkgs.fzf
    # Bash
    #(jq.overrideAttrs (addMetaAttrs : { priority = 10;}))
    jq
    # unstable.nodePackages.bash-language-server
    # nodePackages.javascript-typescript-langserver
    nodePackages.mermaid-cli
    # Nix
    ghc
    #( import ~/.config/nixpkgs/nixos/overlays/rust/cargo2nix {}).package
    autojump
    #    hnix-lsp
    #dock
    dive

    #desktop
    #Go-lang
    dep
    gosec
    gotests
    gotty
    #blueman
    blueman
    nodejs
  ];
}
