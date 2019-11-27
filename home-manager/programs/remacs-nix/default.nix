with import <nixpkgs> {};

let
  src = fetchFromGitHub {
    owner = "mozilla";
    repo = "nixpkgs-mozilla";
    rev = "50bae918794d3c283aeb335b209efd71e75e3954";
    sha256 = "07b7hgq5awhddcii88y43d38lncqq9c8b2px4p93r5l7z0phv89d";
    # date = 2019-04-02T09:39:52+02:00;
  };
in

with import "${src.out}/rust-overlay.nix" pkgs pkgs;

let
  # as per remacs/rust-toolchain
  rustWithExtensions = ((rustChannelOf { date = "2019-05-01"; channel = "nightly"; }).rust.override {
    extensions = [
      "rust-src"
      "clippy-preview"
      "rls-preview"
      "rust-analysis"
    ];
  });
in

stdenv.mkDerivation rec {
  name = "remacs-${version}${versionModifier}";
  # as per remacs/configure.ac AC_INIT
  version = "27.0.50";
  versionModifier = "-git";

  buildInputs = [
    rustWithExtensions rustfmt rustracer ctags

    systemd texinfo libjpeg libtiff giflib xorg.libXpm gtk3 gnutls
    ncurses libxml2 xorg.libXt imagemagick librsvg gpm dbus libotf
    clang_6 pkgconfig autoconf rustup openssl gdb rr
  ];

  shellHook = ''
    export NIX_PATH="nixpkgs=${toString <nixpkgs>}"
    export LIBCLANG_PATH="${llvmPackages_6.libclang.lib}/lib";
    ctags -o remacs/TAGS -e -R remacs/src/*.c remacs/src/*.h
  '';
}
