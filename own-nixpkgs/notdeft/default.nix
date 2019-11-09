with import <nixpkgs> {};
stdenv.mkDerivation {
  name = "env";
  buildInputs = [ gcc cmake tclap xapian];
}
