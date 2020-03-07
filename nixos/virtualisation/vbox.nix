{ config, pkgs, ...}:
{
  virtualisation = {
    virtualbox = {
      host = {
        enable = true;
        enableExtensionPack = true;
      };
      guest = {
        enable = true;
      };
    };
    kvmgt.enable = true;
  };
  users.extraUsers.myuser.extraGroups = ["vboxusers"];
}
