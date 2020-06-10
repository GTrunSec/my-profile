## https://github.com/NixOS/nixpkgs/issues/77503 openssl 1.0.2 is not supported
let
  src = builtins.fetchTarball {
    url    = "https://github.com/GTrunSec/nixpkgs/tarball/3fac6bbcf173596dbd2707fe402ab6f65469236e";
    sha256 = "1b3dgc6dwh9fk05fngwszib2zbil7nkbn4kmf2nxn76dc8dvhr3z";
  };
in
import src
