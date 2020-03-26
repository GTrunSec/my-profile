self: super:

# http://nbp.github.io/slides/NixCon/2017.NixpkgsOverlays/
# https://blog.flyingcircus.io/2017/11/07/nixos-the-dos-and-donts-of-nixpkgs-overlays/

{
  #gomplate     = super.callPackage ./package/gomplate {};
  govet = super.callPackage ./govet { };
}
