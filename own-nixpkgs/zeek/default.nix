with import <nixpkgs> {};  
stdenv.mkDerivation rec {
  name = "zeek-3.0.0";

  src = fetchurl {
    url = "https://www.bro.org/downloads/${name}.tar.gz";
    sha256 = "16pz5fh0z1hmvhn8pxqmdm5a9d8mqrp4gxpxkaywnaqk2h598lmm";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap perl zlib curl geoip gperftools python swig ];

  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.
  cmakeFlags = [ "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}" ];

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = https://www.bro.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub ];
    platforms = with platforms; linux;
  };
}
