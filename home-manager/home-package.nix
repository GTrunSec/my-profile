with import <nixpkgs> {};
let
  nixpkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
  remacs = (import ./programs/remacs-nix/build.nix) {};
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
    #remacs
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
    lm_sensors
    #image
    gimp
    #brower
    # (brave.overrideDerivation (oldAttrs: {
    #   version = "1.3.4";
    #   src = fetchurl {
    #     url = "https://github.com/brave/brave-browser/releases/download/v1.3.4/brave-browser-nightly_1.3.4_amd64.deb";
    #     sha256 = "093m2p046v89sisy5gs08qnqx8jf6d488a5ws8vcyg5h6hyfdcqr";
    #   };
    # }))
    brave
    #chat
    signal-desktop
    #music
    cmus
    compton
    discord
    #skim
    screenfetch
    (polar-bookshelf.overrideDerivation (oldAttrs: {
      src = fetchurl {
        url = "https://github.com/burtonator/polar-bookshelf/releases/download/v1.60.11/polar-bookshelf-1.60.11-amd64.deb";
        sha256 = "0iar1xjkwgld539c1glh9c7832iq6a5lq1g9ngk5r6bhmpx2szl9";
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
    gotty
    #blueman
    blueman
    nodejs
  ];
}
