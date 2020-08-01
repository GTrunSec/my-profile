{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
    };
    kvmgt.enable = true;
  };
  #virtualisation.vmware.host.enable = true;
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
}
