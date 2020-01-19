#with import <nixpkgs> {};
{pkgs, appimage-run, fetchurl, writeScriptBin}:
let
  name   = "nuclear";
  categories = "AudioVideo";
  nuclear-app = fetchurl{
    name   = "nuclear";
    url    =  "https://github.com/nukeop/nuclear/releases/download/v0.5.1/nuclear-7e3bac.AppImage";
    sha256 = "1hr0s8fmrdpxycz9yh5pj2jidqy298hq6j99m63fcpkli9zx197n";
    executable = true;
  };
    icon   = fetchurl {
    url    = https://github.com/nukeop/nuclear/raw/master/resources/media/1024x1024.png;
    sha256 = "0h0mqdwr6dx4nmnr35vbspqnzlpdwhvikq29xvb9a6038gqj3ss4";
  }; 

in

 writeScriptBin "nuclear" ''
         exec ${appimage-run}/bin/appimage-run ${nuclear-app} "$@"
''
  # icon   = fetchurl {
  #   url    = https://github.com/nukeop/nuclear/raw/master/resources/media/1024x1024.png;
  #   sha256 = "0h0mqdwr6dx4nmnr35vbspqnzlpdwhvikq29xvb9a6038gqj3ss4";
  # }; 
 # categories = "AudioVideo";
