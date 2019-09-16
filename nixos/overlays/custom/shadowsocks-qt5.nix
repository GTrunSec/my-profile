self: super:

{
  shadowsocks-qt5= super.stdenv.mkDerivation rec {
    name = "shadowsocks-qt5-${version}";
    version = "v3.0.1";
    src = super.fetchurl {
    name   = "shadowsocks-qt5";
    url    = "https://github.com/shadowsocks/shadowsocks-qt5/releases/download/v3.0.1/Shadowsocks-Qt5-3.0.1-x86_64.AppImage";
    sha256 = "1957yi8pg7kxpsb3nln481cyfsz2glm2jbi1jciqkg64zl3g3nvr";
    };

    buildInputs = [ super.appimage-run ];

    unpackPhase = ":";

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp $src $out/share/shadowsocks-qt5.AppImage
      echo "#!${super.runtimeShell}" > $out/bin/shadowsocks-qt5
      echo "${super.appimage-run}/bin/appimage-run $out/share/shadowsocks-qt5.AppImage" >> $out/bin/shadowsocks-qt5
      chmod +x $out/bin/shadowsocks-qt5 $out/share/shadowsocks-qt5.AppImage
    '';
  };
}
