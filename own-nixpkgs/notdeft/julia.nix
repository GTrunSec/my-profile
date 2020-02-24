let
  ownpkgs_git = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/tarball/c4fe8c0f69f9701fa5c7ae819285de8c8c9bdbf6";
    sha256 = "1cfm7kcxvdi88y7ij3cgylmmzyfw7ryywc06v1a1p1r0a9lpy3wy";
  };

  ownpkgs = (import ownpkgs_git) { };

in

ownpkgs.stdenv.mkDerivation {
  name = "julia";
  buildInputs =[ ownpkgs.julia_13 ];
  buildPhase = ''
   export JULIA_CPU_THREADS=12
    '';
}
