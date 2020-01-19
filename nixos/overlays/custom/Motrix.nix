self: super:

{
  motrix = super.stdenv.mkDerivation rec {
    name = "motrix-${version}";
    version = "v1.4.1";
    src = super.fetchurl {
    name   = "motrix";
    url    = "https://github.com/agalwood/Motrix/releases/download/v1.4.1/Motrix-1.4.1-x86_64.AppImage";
    sha256 = "1lyl9kzzribr31k9jzqzc4v21q1grckl755iywc6264fwm0nmfjl";
    };

    buildInputs = [ super.appimage-run ];

    unpackPhase = ":";

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp $src $out/share/motrix.AppImage
      echo "#!${super.runtimeShell}" > $out/bin/motrix
      echo "${super.appimage-run}/bin/appimage-run $out/share/motrix.AppImage" >> $out/bin/motrix
      chmod +x $out/bin/motrix  $out/share/motrix.AppImage
    '';
  };
}
