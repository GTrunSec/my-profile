let
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs { };
in
 nixpkgs.buildEnv {
  name = "env";
  paths = [
    #nixpkgs.julia_13
    nixpkgs.R
    ];
}
