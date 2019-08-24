{pkgs, lib, config, options, modulesPath}:

{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" ];
  virtualisation.libvirtd.enable = true;
  virtualisation.virtualbox.host.enable = true;
  boot.extraModprobeConfig = "options kvm_intel nested=1";
}
