with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [ librime cmake ];
}
