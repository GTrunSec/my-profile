{ appimageTools, fetchurl, lib, gsettings-desktop-schemas, gtk3 }:

let
  pname = "nteract";
  version = "0.22.4";
in appimageTools.wrapType2 rec {
    name = "${pname}-${version}";
    src = fetchurl {
    name   = "nteract";
    url    = "https://github.com/nteract/nteract/releases/download/v0.22.4/nteract-0.22.4.AppImage";
    sha256 = "1pnirmfgdiijk3pg19qyg33ybs4bvvh1sx6pc8pxvfvh9vfn5fx5";
    };

  profile = ''
    export LC_ALL=C.UTF-8
    export XDG_DATA_DIRS=${gsettings-desktop-schemas}/share/gsettings-schemas/${gsettings-desktop-schemas.name}:${gtk3}/share/gsettings-schemas/${gtk3.name}:$XDG_DATA_DIRS
  '';

  multiPkgs = null; # no 32bit needed
    extraPkgs = p: (appimageTools.defaultFhsEnvArgs.multiPkgs p) ++ [
    p.gtk3
  ];

  extraInstallCommands = "mv $out/bin/{${name},${pname}}";

  meta = with lib; {
    description = "The interactive computing suite for you";
  };
}
