with import <nixpkgs> {};
let
  nixpkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
  unstable = import <nixpkgs-unstable> { };
  # Currently not used in favour of nix-mode
  # hnix-lsp = import (pkgs.fetchFromGitHub {
  #   owner = "domenkozar";
  #   repo = "hnix-lsp";
  #   rev = "d678f56639067f54144ae08cdf3657889348723c";
  #   sha256 = "09vasf7kkbag1d1hd2v8wf7amglwbj3xq2qqinh1pv9hb8bdcsg2";
  # });
  
in   {
  home.packages = with nixpkgs;[
    aria2
    xclip
    screenfetch
    urxvt_perls
    ag
    #dnsproxy
    graphviz
    rofi
    pkgs.pandoc
    fd
    ripgrep
    feh
    lsof
    #chat
    signal-desktop
    #music
    cmus
    compton
    discord
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
      orgbabelhelper
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
    jq
    #dock
    dive

    #desktop
    #Go-lang
    dep
    gosec
    #blueman
    blueman
    nodejs
  ];
}
