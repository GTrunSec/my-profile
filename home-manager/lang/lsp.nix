{ config, pkgs, lib, ... }:
with import <nixpkgs> { };

 let
  nixos = import <nixos> { };
  unstable = import <nixpkgs-unstable> { };
  # Currently not used in favour of nix-mode
  # hnix-lsp = import (pkgs.fetchFromGitHub {
  #   owner = "domenkozar";
  #   repo = "hnix-lsp";
  #   rev = "d678f56639067f54144ae08cdf3657889348723c";
  #   sha256 = "09vasf7kkbag1d1hd2v8wf7amglwbj3xq2qqinh1pv9hb8bdcsg2";
  # });
  
in
  {
    home.packages = with pkgs;[
    (python3.withPackages (pkgs: with pkgs; [
          # rl algorithms
         pip
         pytest
         numpy
         scikitlearn
         bat
         matplotlib
         sqlalchemy
         pandas
      ]))   
    #  Go
    # C / C++
    ccls
    #zeek
    rocksdb
    sqlite
    
    fish-foreign-env
    # Bash
    # unstable.nodePackages.bash-language-server
    nodePackages.javascript-typescript-langserver
    # Nix
    ghc
    autojump
    #    hnix-lsp
    pkgs.blueman
  ];
}
