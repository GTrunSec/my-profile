{ pkgs }: with pkgs; with (import ./build-appimage.nix { inherit pkgs; });
buildAppImage {
  name   = "Nuclear";
  url    = https://github.com/nukeop/nuclear/releases/download/v0.4.3/nuclear-0.4.3-x86_64.AppImage;
  sha256 = "10hfv44wz7by8yy18s4qxqr21rxf4m6ifqrpr62mbz5n7clns343";
  icon   = fetchurl {
    url    = https://github.com/nukeop/nuclear/raw/master/resources/media/1024x1024.png;
    sha256 = "0h0mqdwr6dx4nmnr35vbspqnzlpdwhvikq29xvb9a6038gqj3ss4";
  }; 
  categories = "AudioVideo";
}
