{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn }:

buildGoPackage rec {
  name = "deepsea";
  version = "master";
  rev = "59270d8d54f686ff6e41ca21d7c1d4b9a813bb1c";

  goPackagePath = "src/deepsea";
  src = fetchgit {
    inherit rev;
    url = "https://github.com/GTrunSec/deepsea";
    sha256 = "16q2ng4ik3zv84gpzy2038skbcl6r5p0yy55rxx99q2bqyc4gqv1";
  };

  goDeps = ./deps.nix;

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    description = "Deep Sea Phishing https://dsnezhkov.github.io/deepsea/";
    homepage = "https://github.com/GTrunSec/deepsear";
  };
}
