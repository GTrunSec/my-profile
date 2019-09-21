{ pkgs ? import <nixpkgs> {}
}:
{
#{ fetchurl, runCommand }: {
  buildAppImage = { name, url, sha256, icon, categories }:
  let
    image = fetchurl {
      inherit url sha256;
      executable = true;
    };
  in
    runCommand name {} ''
      binDir="$out/bin"
      mkdir -p $binDir
      cat > ''${binDir}/${name} <<EOF
      #!${stdenv.shell}
      ${appimage-run}/bin/appimage-run ${image}
      EOF
      chmod +x ''${binDir}/${name}
      mkdir -p $out/share/applications
      cat > $out/share/applications/${name}.desktop <<EOF
      [Desktop Entry]
      Type=Application
      Exec=$out/bin/${name}
      Terminal=false
      Name=${name}
      Categories=${categories};
      Icon=${icon}
      EOF
    '';
}
