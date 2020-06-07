{ version
, sha256
, libcxxStdenv, llvmPackages, lib, fetchurl, ncurses, autoreconfHook, texinfo
, pkgconfig, libxml2, gettext, gnutls
, withAutoReconf ? false
}:

# A very minimal version of https://github.com/NixOS/nixpkgs/blob/master/pkgs/applications/editors/emacs/default.nix
let stdenv = libcxxStdenv;
in
stdenv.mkDerivation rec {
  name = "emacs-${version}${versionModifier}";
  versionModifier = "";

  src = fetchurl {
    inherit sha256;
    #url = "mirror://gnu/emacs/${name}.tar.gz";
    url = "https://github.com/emacs-mirror/emacs/archive/feature/native-comp/a58fef9f63fd4383c4eae9dfe8ae663b4ed710d1.tar.gz";
  };

  enableParallelBuilding = true;

  CFLAGS = "-DMAC_OS_X_VERSION_MAX_ALLOWED=101200";

  nativeBuildInputs = [ pkgconfig (if withAutoReconf then autoreconfHook else null) ];

  buildInputs =
    [ ncurses libxml2 gnutls gettext texinfo];

  hardeningDisable = [ "format" ];

  configureFlags = [
    # "--disable-build-details" # for a (more) reproducible build
     "--with-modules"
     "--with-x=yes"#
     "--with-x11"
     "--with-xft"
     # "--with-xpm=no"
     # "--with-jpeg=no"
     #  "--with-png=no"
     # "--with-gif=no"
     # "--with-tiff=no"
  ];

  preConfigure = ''
    substituteInPlace lisp/international/mule-cmds.el \
      --replace /usr/share/locale ${gettext}/share/locale
    for makefile_in in $(find . -name Makefile.in -print); do
        substituteInPlace $makefile_in --replace /bin/pwd pwd
    done
    substituteInPlace src/Makefile.in --replace 'LC_ALL=C $(RUN_TEMACS)' 'env -i LC_ALL=C $(RUN_TEMACS)'
  '';
  postInstall = ''

 '';
  installTargets = "tags install";

  meta = with stdenv.lib; {
    description = "The extensible, customizable GNU text editor";
    homepage    = https://www.gnu.org/software/emacs/;
    license     = licenses.gpl3Plus;
    platforms   = platforms.all;

    longDescription = ''
      GNU Emacs is an extensible, customizable text editor—and more.  At its
      core is an interpreter for Emacs Lisp, a dialect of the Lisp
      programming language with extensions to support text editing.
      The features of GNU Emacs include: content-sensitive editing modes,
      including syntax coloring, for a wide variety of file types including
      plain text, source code, and HTML; complete built-in documentation,
      including a tutorial for new users; full Unicode support for nearly all
      human languages and their scripts; highly customizable, using Emacs
      Lisp code or a graphical interface; a large number of extensions that
      add other functionality, including a project planner, mail and news
      reader, debugger interface, calendar, and more.  Many of these
      extensions are distributed with GNU Emacs; others are available
      separately.
    '';
  };
}
