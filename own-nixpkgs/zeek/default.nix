with import <nixpkgs> {};
let
  preConfigure = (import ./shell.nix);
in
stdenv.mkDerivation rec {
  pname = "zeek";
  version = "3.0.2";
  
  src = fetchurl {
    url = "https://www.zeek.org/downloads/zeek-${version}.tar.gz";
    sha256 = "0d5agk6yc4xyx2lwfx6r1psks1373h53m0icyka1jf15b4zjg3m7";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig rocksdb];
  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.
  inherit preConfigure;

  cmakeFlags = [
    "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}"
    "-DENABLE_PERFTOOLS=true"
    "-DINSTALL_AUX_TOOLS=true"
  ];

  enableParallelBuilding = true;


  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = https://www.bro.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub ];
    platforms = with platforms; linux;
  };
}
