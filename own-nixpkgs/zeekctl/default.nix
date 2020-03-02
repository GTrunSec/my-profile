with import <nixpkgs> {};
let
  preConfigure = (import ./shell.nix);
in
stdenv.mkDerivation rec {
  pname = "zeekctl";
  version = "2.1.0";
  
  src = fetchurl {
    url = "https://www.zeek.org/downloads/zeekctl-${version}.tar.gz";
    sha256 = "1ad6xjabx0z672cad1rsj7i0yhqif1mm9paqf0ayd804fwpkgqq9";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig rocksdb zeek];
  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.



  cmakeFlags = [
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
