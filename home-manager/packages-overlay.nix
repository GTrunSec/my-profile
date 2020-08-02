self: super:
let
  nixpkgs-hardenedlinux = super.fetchgit {
    url = "https://github.com/hardenedlinux/nixpkgs-hardenedlinux";
    rev = "59f3d19bac4f00bc39b335b6d9490ca89be45301";
    sha256 = "0nadlq1b0iyj94jxj7d2pgix2gf8zsddc6g8597v4i57rmp9ca6g";
  };
in
{
  zeek = super.callPackage "${nixpkgs-hardenedlinux}/pkgs/zeek" {KafkaPlugin = true; PostgresqlPlugin = true; Http2Plugin = true;};
  vast = super.callPackage "${nixpkgs-hardenedlinux}/pkgs/vast" { };
  pf-ring = super.callPackage ../pkgs/network/pf_ring.nix { };
  osquery = super.callPackages ../pkgs/osquery { };
}
