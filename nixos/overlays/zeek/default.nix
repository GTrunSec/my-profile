{stdenv, fetchurl, cmake, flex, bison, openssl, libpcap, perl, zlib, file, curl
, geoip, gperftools, python, swig, caf}:
stdenv.mkDerivation rec {
    version = "3.0.0-rc2";
    name = "zeek";
    src = fetchurl {
      url = "https://www.zeek.org/downloads/${name}-${version}.tar.gz";
    sha256 = "1a71d5b800d0a4c9699f6ef09bc36a9fefea0525a37de9e68abbcd95d9dbc101";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap perl zlib curl geoip gperftools python swig caf];
  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.

  cmakeFlags = ["-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}"];

  enableParallelBuilding = true;
  
  preConfigure = ''
    cmakeFlags="$cmakeFlags -DINSTALL_AUX_TOOLS:BOOL=true
         -DINSTALL_ZEEKCTL:BOOL=true
         -DZEEK_SPOOL_DIR=/var/lib/zeek/spool
         -DZEEK_LOG_DIR=/var/lib/zeek/logs
         -DZEEK_ETC_INSTALL_DIR=$out/etc" 
'';


  # sed -i '/^host/{s/=.*//;}' $out/etc/node.cfg   
  # sed -i 's/^host/host=10.220.170.137/' $out/etc/node.cfg   
  # sed -i '/^interface/{s/=.*//;}' $out/etc/node.cfg
  # sed -i 's/^interface/interface=enp0s31f6/' $out/etc/node.cfg   
 


  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = https://www.bro.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub ];
    platforms = with platforms; linux;
  };
}
