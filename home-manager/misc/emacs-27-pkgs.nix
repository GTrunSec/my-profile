let
  src = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/tarball/b7f877078bfeea47aa420904f70a6bf7532b1319";
    sha256 = "192g7pspb9qdr63qzaly38zfni7s7hrnxi12ppwcyq0nf9vrdavl";
  };
in
import src
