# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./systemPackages.nix
      ./pc-common.nix
      ./virtualisation
      ./theme
      ./device-setting
      ./lang
      ./nsm
      # ./hydra.nix               
    ];

  boot.extraModprobeConfig = ''
       options snd-hda-intel model=ALC1220
       '';
  
  # Use the systemd-boot EFI boot loader.
  boot.loader.systemd-boot.enable = true;
  boot.loader.efi.canTouchEfiVariables = true;
  
  networking.hostName = "nixos"; # Define your hostname.
  # networking.wireless.enable = true;  # Enables wireless support via wpa_supplicant.

  # ssd trimming
  services.fstrim.enable = true;

  nix.autoOptimiseStore = true;

  # Supposedly better for the SSD.
  
  fileSystems."/".options = [ "noatime" "nodiratime" "discard" ];
  
  # Configure network proxy if necessary
  # networking.proxy.default = "http://user:password@proxy:port/";
  # networking.proxy.noProxy = "127.0.0.1,localhost,internal.domain";
  

  # Select internationalisation properties.
  i18n = {
     defaultLocale = "en_US.UTF-8";
     consoleFont = "Lat2-Terminus16";
     inputMethod.enabled = "fcitx";
     inputMethod.fcitx.engines = [ pkgs.fcitx-engines.rime ];
  };

  programs.fish.enable = true;

  # Set your time zone.
  
   time.timeZone = "America/Los_Angeles";

  # List packages installed in system profile. To search, run:
  # $ nix search wget

  # Some programs need SUID wrappers, can be configured further or are
  # started in user sessions.
  # programs.mtr.enable = true;
  # programs.gnupg.agent = { enable = true; enableSSHSupport = true; };

  # List services that you want to enable:

  # Enable the OpenSSH daemon.
  services.openssh.enable = true;
  # Open ports in the firewall.
  # networking.firewall.allowedTCPPorts = [ ... ];
  # networking.firewall.allowedUDPPorts = [ ... ];
  # Or disable the firewall altogether.
  # networking.firewall.enable = false;

  # Enable CUPS to print documents.
  # services.printing.enable = true;

  # Enable sound.
  sound.enable = true;


  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.gtrun = {
     home = "/home/gtrun";
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "pulse" "sound" "libvirtd"
                     "video"
                     "docker"
                   ]; # Enable ‘sudo’ for the user.
     shell = "/run/current-system/sw/bin/fish";
     uid = 1000;
     openssh.authorizedKeys.keys = [
       "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCkSgUxROiIN3k9lBRTXSYqUpHEv+KFTlWhBu4OTASs5sEUtbvUhpn2zeySTNb2SRbFsbECLTmfT2avDC2MeNnbivLAyEEAjSgLcpiwfVithUl2Tx59mFVh2wZs/4jyOQ5uX96kvutiWNb91+kQ27lUXk+3e15mgnKmQTyikENbsqzt79lRqjzj9V0KyuvbccDCcE9ZBSZ9LTKAhelYSZ1PwavsEBdXDZZBBVsRrxyVr1QueitdS3D4bxSBHuwwDHkXK3c/f5GPaYkh6Xnv/RzQkKB2dGu/ulw2up5pLShmGir9PFbhDoPfF/EzE9PbSSZV4EsHhLUu4tRsg4LyBtlN gtrun@GTruN"
                                   ];
     
   };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
