{stdenv, fetchurl, cmake, flex, bison, openssl, libpcap, zlib, file, curl
, libmaxminddb, gperftools, python, swig, fetchpatch, caf,  rdkafka, postgresql, fetchFromGitHub, coreutils
,  callPackage
,  PostgresqlPlugin ? false
,  KafkaPlugin ? false
,  zeekctl ? true
}:
let
  preConfigure = (import ./script.nix {inherit coreutils;});

  pname = "zeek";
  version = "3.0.6";
  confdir = "/var/lib/${pname}";

  plugin = callPackage ./plugin.nix {
    inherit rdkafka postgresql version confdir PostgresqlPlugin KafkaPlugin zeekctl;
  };
in
stdenv.mkDerivation rec {
  inherit pname version;

  src = fetchurl {
    url = "https://download.zeek.org/zeek-${version}.tar.gz";
    sha256 = "1lcanyf5gdfqr7d6cc8ygdpvmn3g94slhw2zwvixnm8w3b15dkap";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig caf
                   rdkafka postgresql  
                ];

  ZEEK_DIST = "${placeholder "out"}";
  #see issue https://github.com/zeek/zeek/issues/804 to modify hardlinking duplicate files.
  inherit preConfigure;

  enableParallelBuilding = true;

  patches = stdenv.lib.optionals stdenv.cc.isClang [
    # Fix pybind c++17 build with Clang. See: https://github.com/pybind/pybind11/issues/1604
    (fetchpatch {
      url = "https://github.com/pybind/pybind11/commit/759221f5c56939f59d8f342a41f8e2d2cacbc8cf.patch";
      sha256 = "0l8z7d7chq1awd8dnfarj4c40wx36hkhcan0702p5l89x73wqk54";
      extraPrefix = "aux/broker/bindings/python/3rdparty/pybind11/";
      stripLen = 1;
    })
  ];

  cmakeFlags = [
    "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}"
    "-DENABLE_PERFTOOLS=true"
    "-DINSTALL_AUX_TOOLS=true"
    "-DINSTALL_ZEEKCTL=true"
    "-DZEEK_ETC_INSTALL_DIR=${placeholder "out"}/etc"
    "-DCAF_ROOT_DIR=${caf}"
  ];

  inherit (plugin) postFixup;
  
  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = "https://www.zeek.org";
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub marsam tobim ];
    platforms = platforms.unix;
  };
}
