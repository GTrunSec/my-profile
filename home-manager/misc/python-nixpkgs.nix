## https://github.com/NixOS/nixpkgs/issues/77503 openssl 1.0.2 is not supported
let
  src = builtins.fetchTarball {
    url = "https://github.com/NixOS/nixpkgs/tarball/102fa5492c071f634b9c741e137551c2d93216e2";
    sha256 = "03n28ch6n21hxwx62q29qgz4k7j1vx0c7wj2zxbwn1qg6pkylncy";
  };
in
import src
