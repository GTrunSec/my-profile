{ config, lib, pkgs, ... }:
let
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs {  };
  clean-nix-store = nixpkgs.writeScriptBin "clean-nix-store" (import ../bin/clean-nix-store.nix { });
  stable  = import ./stable-pkgs.nix { config={ allowUnfree=true; allowBroken=true; ignoreCollisions = true;};};
  zeek-own = pkgs.callPackage ../own-nixpkgs/zeek {};
in
{

  config = with lib; mkMerge [

    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with stable;[
        vips
      ];
    })


    ##public pkgs
    (mkIf (pkgs.stdenv.isLinux || pkgs.stdenv.isDarwin) {
      home.packages = with nixpkgs;[
        gopass
        xapian
        tclap
        gitAndTools.delta
        clean-nix-store
        nodePackages.node2nix
        system-sendmail
        zeek-own
        pypi2nix
        poetry
        #vips
        nixpkgs-review
        #for emacs notdeft
        tclap xapian
      ];
    })


    (mkIf pkgs.stdenv.isLinux {
      home.packages = with nixpkgs;[
        #remacs
        rnix-lsp
        aria2
        #zeek
        tcpreplay
        xclip
        screenfetch
        urxvt_perls
        ag
        bat
        hunspell
        gitkraken
        suricata
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
            url = "https://github.com/burtonator/polar-bookshelf/releases/download/v1.100.13/polar-bookshelf-1.100.13-amd64.deb";
            sha256 = "0i60np4akhvzqpspg5k2mz8q4ccmz19j43x1sisbdw7iml1a1rsd";
          };
        }))
        exa
        deepin.deepin-screenshot
        deepin.deepin-turbo
        #overlay
        nteract
        gsettings-desktop-schemas
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
        tree
        vgo2nix
        #emacs eaf
        lxqt.qtermwidget

        deepsea
        libvterm
        libtool

        (python3.buildEnv.override {
          extraLibs = with python3Packages; [
            shapely
            # (pylint.overridePythonAttrs (oldAttrs: {
            #   src = fetchPypi {
            #     pname = "pylint";
            #     version = "2.5.2";
            #     sha256 = "1344f6zrv3airdls19pbqs7vrb2ky0r09m1y53167w9s1y2k2pmr";
            #   };
            # }))
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
          #ipynb-py-convert
          pytest
          scikitlearn
          zat
          matplotlib
          sqlalchemy
          pandas
          voila
          python-language-server
          pygments
          orgbabelhelper
          wakatime
          ];
          ignoreCollisions = true;
        })
        ncat
        #Go
        wakatime
        horcrux
        rocksdb
        sqlite
        fish-foreign-env
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
    })
  ];
}
