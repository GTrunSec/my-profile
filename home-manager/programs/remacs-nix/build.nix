{ local ? false }:

with import <nixpkgs> {};

let
  nixpkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
  remacsSource = import ./remacs-source.nix { inherit local; };
  remacs = import ./remacs.nix { inherit remacsSource local; } ;
  customEmacs = dontRecurseIntoAttrs (emacsPackagesNgFor remacs);
  packages = import ./packages.nix {};
in

customEmacs.emacsWithPackages packages
