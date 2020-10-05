let
  rev = (builtins.fromJSON (builtins.readFile ../../flake.lock)).nodes.master.locked.rev;
  src = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/archive/${rev}.tar.gz";
    sha256 = (builtins.fromJSON (builtins.readFile ../../flake.lock)).nodes.master.locked.narHash;
  };
in
import src
