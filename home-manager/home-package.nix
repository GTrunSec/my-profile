{ config, pkgs, lib, ... }:
with import <nixpkgs> {};
let
#  nixos = import <nixos> { };
  unstable = import <nixpkgs-unstable> { };
  # Currently not used in favour of nix-mode
  # hnix-lsp = import (pkgs.fetchFromGitHub {
  #   owner = "domenkozar";
  #   repo = "hnix-lsp";
  #   rev = "d678f56639067f54144ae08cdf3657889348723c";
  #   sha256 = "09vasf7kkbag1d1hd2v8wf7amglwbj3xq2qqinh1pv9hb8bdcsg2";
  # });
  
in   {
  home.packages = with pkgs;[
    aria2
    xclip
    urxvt_perls
    ag
    dnsproxy
    graphviz
    rofi
    pkgs.pandoc
    fd
    ripgrep
    feh
    lsof
    #music
    pkgs.cmus
    pkgs.compton
    #skim
    screenfetch
    #overlay
    outline-client
    youtube-dl
    shadowsocks-qt5
    sshfs
    ms-pyls
    #nur
    imgcat
    motrix
    (python3.withPackages (pkgs: with pkgs; [
      # rl algorithms
      pip
      pytest
      numpy
      orgparse
      jupyter_core
      ipynb-py-convert
      scikitlearn
      bat
      matplotlib
      sqlalchemy
      pandas
      ipython
      notebook
      ipykernel
    ]))   
    #  Go
    #zeek
    rocksdb
    sqlite
    fish-foreign-env
    pkgs.fzf
    # Bash
    # unstable.nodePackages.bash-language-server
    # nodePackages.javascript-typescript-langserver
    # Nix
    ghc
    autojump
    #    hnix-lsp
    pkgs.jq
    #dock
    pkgs.dive

    #desktop
    #Go-lang
    pkgs.dep
    pkgs.gosec
    #blueman
    pkgs.blueman
    pkgs.nodejs
  ];
}
