self: super:

# http://nbp.github.io/slides/NixCon/2017.NixpkgsOverlays/
# https://blog.flyingcircus.io/2017/11/07/nixos-the-dos-and-donts-of-nixpkgs-overlays/

{
  gooutline    = super.callPackage ./package/gooutline {};
  gosymbols    = super.callPackage ./package/gosymbols {};
  gogetdoc     = super.callPackage ./package/gogetdoc {};
  gomodifytags = super.callPackage ./package/gomodifytags {};
  gopkgs       = super.callPackage ./package/gopkgs {};
  goreturns    = super.callPackage ./package/goreturns {};
  gotests      = super.callPackage ./package/gotests {};
  goimpl       = super.callPackage ./package/goimpl {};
  gorerun      = super.callPackage ./package/gorerun {};
  goforego     = super.callPackage ./package/goforego {};
  govendor     = super.callPackage ./package/govendor {};
  gotorch      = super.callPackage ./package/gotorch {};
  gomplate     = super.callPackage ./package/gomplate {};

}
