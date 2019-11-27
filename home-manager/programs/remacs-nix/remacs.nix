{ remacsSource ? ./remacs, local ? true }:

with import <nixpkgs> {};

let src = fetchFromGitHub {
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
  rust = (rustChannelOf { date = "2019-05-01"; channel = "nightly"; }).rust;
in

let
  remacsRust = import ./remacs-rust.nix { remacsSource = remacsSource; };
in

stdenv.mkDerivation rec {
  name = "remacs-${version}${versionModifier}";
  # as per remacs/configure.ac AC_INIT
  version = "27.0.50";
  versionModifier = if local then "-git" else "";

  src = remacsSource;

  enableParallelBuilding = true;

  buildInputs = [
    rust systemd texinfo libjpeg libtiff giflib xorg.libXpm gtk3
    gnutls ncurses libxml2 xorg.libXt imagemagick librsvg gpm dbus
    libotf pkgconfig autoconf clang llvmPackages.libclang git
  ];

  patches = [./files/autogen-sh-0001.patch];

  postPatch = ''
    pwd="$(type -P pwd)"
    substituteInPlace Makefile.in --replace "/bin/pwd" "$pwd"
    substituteInPlace lib-src/Makefile.in --replace "/bin/pwd" "$pwd"
  '';

  preConfigure = ''
    ./autogen.sh
  '';

  LIBCLANG_PATH = "${llvmPackages.libclang}/lib";

  # redirect Cargo to use pre-built remacs rust sources instead
  preBuild = ''
    export HOME=${remacsRust};
  '';

  makeFlags = [
    "CARGO_FLAGS=-Zoffline" # soon --offline
  ];

  configureFlags = [
    "--enable-rust-debug"
  ];

  # the nixpkgs emacs wrapper requires these paths to be present
  postInstall = ''
    # ln -s $out/bin/remacs $out/bin/remacs
    # ln -s $out/bin/remacsclient $out/bin/remacsclient
    # ln -s $out/share/remacs $out/share/remacs

    mkdir -p $out/share/remacs/site-lisp
    cp ${./files/site-start.el} $out/share/remacs/site-lisp/site-start.el
    $out/bin/remacs --batch -f batch-byte-compile $out/share/remacs/site-lisp/site-start.el
  '';

  meta = {
    homepage = "https://github.com/remacs/remacs";
    description = "A community-driven port of Emacs to Rust.";
    platforms = with stdenv.lib.platforms; unix;
  };
}
