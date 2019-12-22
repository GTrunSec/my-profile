{pkgs, ...}:
with pkgs;
let
  julia = julia_11;
  d = version: "v${lib.concatStringsSep "." (lib.take 2 (lib.splitString "." version))}";
  extraLibs = [
    # IJulia.jl
    mbedtls
    zeromq3
    # ImageMagick.jl
    imagemagickBig
    # HDF5.jl
    hdf5
    # Cairo.jl
    cairo
    gettext
    pango.out
    glib.out
    # Gtk.jl
    gtk3
    gdk_pixbuf
    # GZip.jl # Required by DataFrames.jl
    gzip
    zlib
    # GR.jl # Runs even without Xrender and Xext, but cannot save files, so those are required
    xorg.libXt
    xorg.libX11
    xorg.libXrender
    xorg.libXext
    glfw
    freetype
    # Flux.jl
    cudatoolkit
    cudnn
    linuxPackages.nvidia_x11
    git gitRepo gnupg autoconf curl
    procps gnumake utillinux m4 gperf unzip
    #libGLU_combined
    xorg.libXi xorg.libXmu freeglut
    xorg.libXext xorg.libX11 xorg.libXv xorg.libXrandr zlib
    ncurses5 stdenv.cc binutils
    # Arpack.jl
    arpack
    gfortran.cc
    (pkgs.runCommand "openblas64_" {} ''
      mkdir -p "$out"/lib/
      ln -s ${openblasCompat}/lib/libopenblas.so "$out"/lib/libopenblas64_.so.0
    '')
  ];
in
stdenv.mkDerivation rec {
  name = "julia-env";
  version = julia.version;
  nativeBuildInputs = [ makeWrapper cacert git pkgconfig which ];
  buildInputs = [
    julia
    /* jupyterEnv  # my custom jupyter */
  ] ++ extraLibs;
  phases = [ "installPhase" ];
  installPhase = ''
    export CUDA_PATH="${cudatoolkit}"
    export LD_LIBRARY_PATH=${lib.makeLibraryPath extraLibs}
    # pushd $JULIA_PKGDIR/${d version}
    makeWrapper ${julia}/bin/julia $out/bin/julia \
        --prefix LD_LIBRARY_PATH : "$LD_LIBRARY_PATH" \
        --prefix LD_LIBRARY_PATH ":" "${linuxPackages.nvidia_x11}/lib" \
        --set CUDA_PATH "${cudatoolkit}" \
        --set JULIA_PKGDIR $JULIA_PKGDIR
        # --set JULIA_LOAD_PATH $JULIA_PKGDIR/${d version}
  '';
}
