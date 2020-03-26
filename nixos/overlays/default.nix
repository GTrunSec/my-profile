self: super:
{
  
  zat = super.callPackage ./python/zat {};
  orgparse = super.callPackage ./python/orgparse {};
  ipynb-py-convert = super.callPackage ./python/ipynb-py-convert {};
  #zeek = super.callPackage ./zeek {};
  vast = super.callPackage ./vast {};
  dnsproxy = super.callPackage ./system/adguard-dns.nix {};
  deepsea = super.callPackage ./go/deepsea {};
  horcrux = super.callPackage ./go/horcrux {};
  orgbabelhelper = super.callPackage ./python/orgbabelhelper {};
  wakatime = super.callPackage ./python/wakatime {};
#  adguardhome = super.callPackage ./go/adguard-home {};
  #  outline-client = super.callPackage ./custom/outline-client.nix {};
}
