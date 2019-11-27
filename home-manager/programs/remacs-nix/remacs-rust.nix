{ remacsSource ? ./remacs }:

with import <nixpkgs> {};

let
  fetchcargo = import <nixpkgs/pkgs/build-support/rust/fetchcargo.nix> {
    inherit (pkgs) stdenv cacert git cargo python3;
  };
in

# we want to version cargo vendored sources (via -x or
# --explicit-version) since remacs uses different versions of the same
# library. we hack this into the custom cargoUpdateHook.
let doVersionedUpdate = ''
  mkdir -p $out/versioned
  cargo vendor $out/versioned
'';
in

let remacsRustBindings = fetchcargo rec {
  name = "remacsRustBindings";
  sourceRoot = null;
  srcs = null;
  src = "${remacsSource}/rust_src/remacs-bindings";
  cargoUpdateHook = doVersionedUpdate;
  patches = [];
  sha256 = "0nmq4f4j0c02zp5hb9f49an64fi1q7zp0wmy7w61dwjp5kqv8k0i";
};
in

let remacsRustSrc = fetchcargo rec {
  name = "remacsRustSrc";
  sourceRoot = null;
  srcs = null;
  src = "${remacsSource}/rust_src";
  cargoUpdateHook = ''
    sed -e 's/@CARGO_.*@//' Cargo.toml.in > Cargo.toml
  '' + doVersionedUpdate;
  patches = [];
  sha256 = "1dsrz62w7wnnldm6qfla8af61ws1lid4y9k47bdriv2aqllcis7w";
};
in

let remacsHashdir = fetchcargo rec {
  name = "remacsHashdir";
  sourceRoot = null;
  srcs = null;
  src = "${remacsSource}/lib-src/hashdir";
  cargoUpdateHook = doVersionedUpdate;
  patches = [];
  sha256 = "0vzxpvjc5rylm9hzx2q0cj091c1c53hp13y98kddnp8g43n4jx7y";
};
in

stdenv.mkDerivation {
  name = "remacsRust";
  srcs = [ remacsRustBindings remacsHashdir remacsRustSrc ];
  sourceRoot = ".";
  phases = [ "unpackPhase" "installPhase" ];
  installPhase = ''
    mkdir -p $out/.cargo/registry
    cat > $out/.cargo/config << EOF
      [source.crates-io]
      registry = "https://github.com/rust-lang/crates.io-index"
      replace-with = "vendored-sources"
      [source.vendored-sources]
      directory = "$out/.cargo/registry"
    EOF
    cp -R remacsRustBindings-vendor/versioned/* $out/.cargo/registry
    cp -R remacsHashdir-vendor/versioned/* $out/.cargo/registry
    cp -R remacsRustSrc-vendor/versioned/* $out/.cargo/registry
  '';
}
