{ stdenv, buildGoPackage, fetchgit, fetchhg, fetchbzr, fetchsvn, nodejs, git, golangci-lint }:

buildGoPackage rec {
  name = "AdGuardHome";
  version = "master";
  rev = "04de9d0f7bb1e59c2738538431ee90b1429fca0d";

  goPackagePath = "src/adguardhome";
  src = fetchgit {
    inherit rev;
    url = "https://github.com/AdguardTeam/AdGuardHome.git";
    sha256 = "0hpfr3b7izvfhm6x8sx5yf6jr4xfrswjcg44d7vc5x26raz8x89i";
  };

  goDeps = ./deps.nix;

  HOME = ".";

  buildInputs = [ nodejs git golangci-lint ];
  preConfigure = ''
    sh $PWD/ci.sh
    '';

  # TODO: add metadata https://nixos.org/nixpkgs/manual/#sec-standard-meta-attributes
  meta = {
    description = "Network-wide ads & trackers blocking DNS server";
    homepage = "https://github.com/AdguardTeam/AdGuardHome.git";
  };
}
