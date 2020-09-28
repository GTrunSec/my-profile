## https://github.com/NixOS/nixpkgs/issues/77503 openssl 1.0.2 is not supported
let
  src = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/tarball/064e082296ceea51bf6f14424e5eca1506836a20";
    sha256 = "0i37zzsh2h0wx7y7sppxaqbvjv9wxpxkr8y78zzsp4w27rpj3dmi";
  };
in
import src
