let
    pkgs = {
    nixpkgs = builtins.fetchTarball {
      url = "https://github.com/NixOS/nixpkgs-channels/tarball/9c0968fd8103a32b05c72d8137e6d9e388a86a7e";
      sha256 = "1w03f25vmwd5byj4ccbdxy0iarprysscqyv7vr74f7n78clfabcq";
    };
    };
    nixpkgs  = import pkgs.nixpkgs { };
in
nixpkgs.stdenv.mkDerivation {
  name = "env";
  #cargo 1.38
  buildInputs = [ nixpkgs.cargo nixpkgs.gcc nixpkgs.rustup nixpkgs.rustc ];
}
