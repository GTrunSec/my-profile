{pkgs, lib, config, options, modulesPath}:

{
  boot.kernelModules = [ "kvm-amd" "kvm-intel" "vfio_virqfd" "vfio_pci" "vfio_iommu_type1" "vfio"];
  virtualisation = {
    libvirtd = {
    enable = true;
    #qemuOvmf = true;
    };
  };
  virtualisation.virtualbox.host.enable = true;
  virtualisation.virtualbox.host.enableExtensionPack = true;
  users.extraGroups.vboxusers.members = [ "gtrun" "nsm" "test"];
 #  boot.extraModprobeConfig = "options kvm_intel nested=1";
 #  #https://forum.level1techs.com/t/nixos-vfio-pcie-passthrough/130916
 #  boot.kernelParams = [ "intel_iommu=on" ];
 #  boot.blacklistedKernelModules = [ "radeon" "amdgpu" ];
 #  boot.postBootCommands = ''
 #    DEVS="0000:02:00.0 0000:02:00.1"
 #    for DEV in $DEVS; do
 #      echo "vfio-pci" > /sys/bus/pci/devices/$DEV/driver_override
 #    done
 #    modprobe -i vfio-pci
 # '';

}
