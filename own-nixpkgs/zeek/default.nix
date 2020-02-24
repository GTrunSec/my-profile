with import <nixpkgs> {};  
stdenv.mkDerivation rec {
  pname = "zeek";
  version = "3.0.1";
  
  src = fetchurl {
    url = "https://www.zeek.org/downloads/zeek-${version}.tar.gz";
    sha256 = "1lhik212wrbi092qizc08f3i0b9pj318sxwm0abc5jc3v3pz7x3r";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig rocksdb ];
  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.

  postInstall = ''
  sed -i '1i@load base/frameworks/dpd' $out/share/zeek/base/protocols/dce-rpc/__load__.zeek
  sed -i "1i@load $out/share/zeek/base/frameworks/dpd" $out/share/zeek/base/protocols/dce-rpc/__load__.zeek
  sed -i "1i@load /home/gtrun/src/zeek-3.0.1/scripts/base/frameworks/dpd" $out/share/zeek/base/protocols/dce-rpc/main.zeek
'';

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
