{stdenv, fetchurl, cmake, flex, bison, openssl, libpcap, zlib, file, curl
, libmaxminddb, gperftools, python, swig, writeScript, fetchFromGitHub
, rocksdb, rdkafka, postgresql, pkgs, system-sendmail, caf, fetchpatch}:

let
  preConfigure = (import ./script.nix);
  install_plugin = writeScript "install_plugin" (import ./install_plugin.nix { });
  zeek-postgresql = fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-plugin.json)).zeek-postgresql;
  metron-bro-plugin-kafka = fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-plugin.json)).metron-bro-plugin-kafka;
in
stdenv.mkDerivation rec {
  pname = "zeek";
  version = "3.0.5";
  confdir = "/var/lib/${pname}";

  src = fetchurl {
    url = "https://download.zeek.org/zeek-${version}.tar.gz";
    sha256 = "031q56hxg9girl9fay6kqbx7li5kfm4s30aky4s1irv2b25cl6w2";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig caf rocksdb rdkafka
                  postgresql
                ];

  ZEEK_DIST = "${placeholder "out"}";
  #see issue https://github.com/zeek/zeek/issues/804 to modify hardlinking duplicate files.
  inherit preConfigure;

  enableParallelBuilding = true;

  # patches = stdenv.lib.optionals stdenv.cc.isClang [
  #   # Fix pybind c++17 build with Clang. See: https://github.com/pybind/pybind11/issues/1604
  #   (fetchpatch {
  #     url = "https://github.com/pybind/pybind11/commit/759221f5c56939f59d8f342a41f8e2d2cacbc8cf.patch";
  #     sha256 = "0l8z7d7chq1awd8dnfarj4c40wx36hkhcan0702p5l89x73wqk54";
  #     extraPrefix = "aux/broker/bindings/python/3rdparty/pybind11/";
  #     stripLen = 1;
  #   })
  # ];

  cmakeFlags = [
    "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}"
    "-DENABLE_PERFTOOLS=true"
    "-DINSTALL_AUX_TOOLS=true"
    "-DINSTALL_ZEEKCTL=true"
    "-DZEEK_ETC_INSTALL_DIR=${placeholder "out"}/etc"
    "-DCAF_ROOT_DIR=${caf}"
  ];

  ##issue https://github.com/zeek/zeek/issues/939
  postFixup = ''
        substituteInPlace $out/etc/zeekctl.cfg \
         --replace "CfgDir = $out/etc" "CfgDir = ${confdir}/etc" \
         --replace "SpoolDir = $out/spool" "SpoolDir = ${confdir}/spool" \
         --replace "LogDir = $out/logs" "LogDir = ${confdir}/logs"

         echo "scriptsdir = ${confdir}/scripts" >> $out/etc/zeekctl.cfg
         echo "helperdir = ${confdir}/scripts/helpers" >> $out/etc/zeekctl.cfg
         echo "postprocdir = ${confdir}/scripts/postprocessors" >> $out/etc/zeekctl.cfg
         ## default disable sendmail
         echo "sendmail=" >> $out/etc/zeekctl.cfg
         ##INSTALL ZEEK Plugins
         bash ${install_plugin} metron-bro-plugin-kafka ${metron-bro-plugin-kafka} ${version}
         bash ${install_plugin} zeek-postgresql ${zeek-postgresql} ${version}

  '';

  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = "https://www.zeek.org";
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub marsam tobim ];
    platforms = platforms.unix;
  };
}
