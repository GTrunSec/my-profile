let
  nixpkgs = import ~/.config/nixpkgs/nixos/channel/nixpkgs { };
in
 nixpkgs.stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    #nixpkgs.julia_13
    (nixpkgs.python3.withPackages (ps: [ ps.py4j ]))
  ];
}
