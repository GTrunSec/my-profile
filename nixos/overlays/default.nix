self: super:
{
  bat = super.callPackage ./python/bat {};
  zeek = super.callPackage ./zeek {};
}
