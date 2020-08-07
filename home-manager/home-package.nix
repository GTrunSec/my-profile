{ config, lib, pkgs, ... }:
let
  overlays = [
      (import ../home-manager/packages-overlay.nix)
  ];
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs { inherit overlays; };
  clean-nix-store = nixpkgs.writeScriptBin "clean-nix-store" (import ../bin/clean-nix-store.nix { });
  stable  = import ./stable-pkgs.nix { config={ allowUnfree=true; allowBroken=true; ignoreCollisions = true;};};
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
        clean-nix-store
        nodePackages.node2nix
        system-sendmail
        pypi2nix
        poetry
        #vips
        nixpkgs-review
        #for emacs notdeft
        tclap
        xapian
        #nix-lsp
        rnix-lsp
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
        suricata
        #dnsproxy
        # deepin.deepin-screenshot
        # deepin.deepin-turbo
        #overlay
        #shadowsocks-qt5
        sshfs
        #ms-pyls
        #nur
        #haskell
        #multi-ghc-travis
        niv
        #downloader
        #motrix
        #adguardhome
        #log database
        #vast
        (python3.buildEnv.override {
          extraLibs = with python3Packages; [
            pytest
            numpy
            #orgparse
            pytest
            scikitlearn
            #zat
            matplotlib
            sqlalchemy
            pandas
            #voila
            python-language-server
            pygments
            #orgbabelhelper
            wakatime
          ];
          ignoreCollisions = true;
        })
        ncat
        #Go
        wakatime
        #horcrux
        rocksdb
        sqlite
        # Bash
        #(jq.overrideAttrs (addMetaAttrs : { priority = 10;}))
        jq
        # unstable.nodePackages.bash-language-server
        # nodePackages.javascript-typescript-langserver
        #nodePackages.mermaid-cli
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
