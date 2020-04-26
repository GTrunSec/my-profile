self: super:

{
  outline-client= super.stdenv.mkDerivation rec {
    name = "outline-client-${version}";
    version = "2020-04-22";
    src = super.fetchurl {
    name   = "outline-client";
    url    = "https://github.com/Jigsaw-Code/outline-client/releases/download/daily-2020-04-22/Outline-Client.AppImage";
    sha256 = "0ynp98lzij58cgjkf5ygmm65rxa008p1hj6fgwr10l1jccw6w4ff";
    };

    buildInputs = [ super.appimage-run ];

    unpackPhase = ":";

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp $src $out/share/outline-client.AppImage
      echo "#!${super.runtimeShell}" > $out/bin/outline-client
      echo "${super.appimage-run}/bin/appimage-run $out/share/outline-client.AppImage" >> $out/bin/outline-client
      chmod +x $out/bin/outline-client $out/share/outline-client.AppImage
    '';
  };
}
