## https://github.com/NixOS/nixpkgs/issues/77503 openssl 1.0.2 is not supported
let
  src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/archive/4c67f879f0ee0f4eb610373e479a0a9c518c51c4.tar.gz";
    sha256 = "1411z0df803g3pzsh5m1w4652mibwbggsza9y96w9bi7w6hrvswg";
  };
in
import src
