final: prev:
let
  rev = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs-hardenedlinux.locked.rev;
  nixpkgs-hardenedlinux = builtins.fetchTarball {
    url = "https://github.com/hardenedlinux/nixpkgs-hardenedlinux/archive/${rev}.tar.gz";
    sha256 = (builtins.fromJSON (builtins.readFile ../flake.lock)).nodes.nixpkgs-hardenedlinux.locked.narHash;
  };

in
rec {
  zeek = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/zeek" { KafkaPlugin = true; PostgresqlPlugin = true; Http2Plugin = true; };
  vast = prev.callPackage "${nixpkgs-hardenedlinux}/pkgs/vast" { };
  # pf-ring = prev.callPackage ../pkgs/network/pf_ring.nix { };
  # osquery = prev.callPackages ../pkgs/osquery { };
}
