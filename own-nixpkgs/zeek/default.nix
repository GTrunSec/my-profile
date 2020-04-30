with import <nixpkgs> {};
let
  preConfigure = (import ./shell.nix);
  metron-bro-plugin-kafka = pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-plugin.json)).metron-bro-plugin-kafka;
  zeek-postgresql = pkgs.fetchFromGitHub (builtins.fromJSON (builtins.readFile ./zeek-plugin.json)).zeek-postgresql;
  install_plugin = pkgs.writeScript "install_plugin" (import ./install_plugin.nix { });
in
stdenv.mkDerivation rec {
  pname = "zeek";
  version = "3.0.3";
  confdir = "/var/db/${pname}";
  src = fetchurl {
    url = "https://old.zeek.org/downloads/zeek-${version}.tar.gz";
    sha256 = "0xlw5v83qbgy23wdcddmvan2pid28mw745g4fc1z5r18kp67i8a2";
  };

  nativeBuildInputs = [ cmake flex bison file ];
  buildInputs = [ openssl libpcap zlib curl libmaxminddb gperftools python swig rocksdb system-sendmail caf makeWrapper
                  rdkafka postgresql
                ];
  # Indicate where to install the python bits, since it can't put them in the "usual"
  # locations as those paths are read-only.
  ZEEK_DIST = "${placeholder "out"}";

  patches = [ ./zeekctl.patch];

  inherit preConfigure;

  cmakeFlags = [
    "-DPY_MOD_INSTALL_DIR=${placeholder "out"}/${python.sitePackages}"
    "-DENABLE_PERFTOOLS=true"
    "-DINSTALL_AUX_TOOLS=true"
    "-DINSTALL_ZEEKCTL=true"
    "-DZEEK_ETC_INSTALL_DIR=${placeholder "out"}/etc"
    "-DCAF_ROOT_DIR=${caf}"
    "-DZEEK_SPOOL_DIR=${confdir}/spool"
    "-DZEEK_LOG_DIR=${confdir}/logs"
  ];

  postFixup = ''
        substituteInPlace $out/etc/zeekctl.cfg \
         --replace "CfgDir = $out/etc" "CfgDir = ${confdir}/etc"
         echo "scriptsdir = ${confdir}/scripts" >> $out/etc/zeekctl.cfg

         bash ${install_plugin} metron-bro-plugin-kafka ${metron-bro-plugin-kafka} ${version}
         bash ${install_plugin} zeek-postgresql ${zeek-postgresql} ${version}
  '';

  enableParallelBuilding = true;

  meta = with stdenv.lib; {
    description = "Powerful network analysis framework much different from a typical IDS";
    homepage = https://www.bro.org/;
    license = licenses.bsd3;
    maintainers = with maintainers; [ pSub ];
    platforms = with platforms; linux;
  };
}
