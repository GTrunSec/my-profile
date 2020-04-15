{ config, lib, pkgs, ... }:
let

  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };
  all-hies = import (fetchTarball "https://github.com/infinisil/all-hies/tarball/master") {};

in

{

  config = with lib; mkMerge [
    (mkIf pkgs.stdenv.isDarwin {
      home.packages = with nixpkgs;[

        bat
        gron
        (all-hies.unstable.selection { selector = p: { inherit (p) ghc865; }; })

      ];
    })
  ];

}
