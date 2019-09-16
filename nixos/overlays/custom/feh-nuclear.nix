self: super:

{
  nuclear = super.stdenv.mkDerivation rec {
    name = "nuclear-${version}";
    version = "v0.5.1";
    src = super.fetchurl {
    name   = "nuclear";
    url    = "https://github.com/nukeop/nuclear/releases/download/v0.5.1/nuclear-7e3bac.AppImage";
    sha256 = "0lpm1wpkfy4ffvhraamf18iyyqk67hh77yz4i62slvcbmx975g99";
    };

    buildInputs = [ super.appimage-run ];

    unpackPhase = ":";

    installPhase = ''
      mkdir -p $out/{bin,share}
      cp $src $out/share/nuclear.AppImage
      echo "#!${super.runtimeShell}" > $out/bin/nuclear
      echo "${super.appimage-run}/bin/appimage-run $out/share/nuclear.AppImage" >> $out/bin/nuclear
      chmod +x $out/bin/nuclear $out/share/nuclear.AppImage
    '';
  };
}
