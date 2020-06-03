let
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs { };
in
 stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    nixpkgs.julia_13
  ];
}
