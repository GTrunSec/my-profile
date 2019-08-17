{stdenv, fetchgit, cmake, flex, bison, openssl, libpcap, perl, zlib, file, curl, geoip, gperftools, python, swig }:

stdenv.mkDerivation rec {
  name    = "bro-master";
  version = "2.7";

  src = fetchgit {
    url    = "https://github.com/zeek/zeek.git";
    rev    = "23a1815e299650de959b1334ced514c2c107fba4";
    deepClone = true;
    sha256 = "0jnk2v9yxvppqphs6sihpfwxsc5l3jday0gvv7d70h884p8x8dq2";
  };

 nativeBuildInputs = [cmake flex bison file ];
 buildInputs = [ openssl libpcap perl zlib curl geoip gperftools python swig ];
 makeFlags="-j8 all";
cmakeFlags = [ "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}" ];
enableParallelBuilding = true;
 configureFlags = [
   "--with-geoip=${geoip}"
];
   meta = with stdenv.lib; {
   description = "Powerful network analysis framework much different from a typical IDS";
   homepage = https://www.zeek.org/;
   license = licenses.bsd3;
   maintainers = with maintainers; [ pSub ];
   platforms = with platforms; linux;
  };
}
