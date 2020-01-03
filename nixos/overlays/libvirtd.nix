self: super:
{
  # Patch libvirt to use ebtables-legacy
  #https://github.com/NixOS/nixpkgs/issues/75878
  libvirt = if super.libvirt.version <= "5.4.0" && super.ebtables.version > "2.0.10-4"
    then
      super.libvirt.overrideAttrs (oldAttrs: rec {
        EBTABLES_PATH="${self.ebtables}/bin/ebtables-legacy";
      })
    else super.libvirt;
}
