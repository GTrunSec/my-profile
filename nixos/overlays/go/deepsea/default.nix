{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "deepsea";
  version = "master";
  rev = "dafd8c60fcbe33e398a0cea01447f16a61476165";

  goPackagePath = "src/deepsea";
  src = fetchgit {
    inherit rev;
    url = "https://github.com/dsnezhkov/deepsea";
    sha256 = "0b40dci28i5i2ap39dz9xpcnmr2nvasck4z2464zsg4qz8l9f803";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    description = "Deep Sea Phishing https://dsnezhkov.github.io/deepsea/";
    homepage = "https://github.com/GTrunSec/deepsear";
  };
}
