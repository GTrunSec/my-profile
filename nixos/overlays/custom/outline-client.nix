self: super:

{
  outline-client= super.stdenv.mkDerivation rec {
    name = "outline-client-${version}";
    version = "v0.5.1";
    src = super.fetchurl {
    name   = "outline-client";
    url    = "https://github.com/Jigsaw-Code/outline-client/releases/download/daily-2019-09-15/Outline-Client.AppImage";
    sha256 = "18p2g7fwq7h5dllwrqv54d677c7anqikqx6abmknyggkbginlsj4";
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
