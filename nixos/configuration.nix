# Edit this configuration file to define what should be installed on
# your system.  Help is available in the configuration.nix(5) man page
# and in the NixOS manual (accessible by running ‘nixos-help’)

{ config, pkgs, ... }:

{
  imports =
    [ # Include the results of the hardware scan.
      ./hardware-configuration.nix
      ./bluetool.nix
      ./pulse.nix
      ./systemPackages.nix
      ./fonts.nix
      ./virtualisation/docker.nix
      ./virtualisation/libvirtd.nix
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

  # Enable the X11 windowing system.

  services.xserver = {
    enable = true;
    windowManager.default = "i3";
    #displayManager.slim.autoLogin = true;
    layout = "us";
    desktopManager.plasma5.enable = true;
    # Enable touchpad support.
    # libinput.enable = true;
    displayManager.slim = {
      enable = true;
	    autoLogin = true;
		  defaultUser = "gtrun";
		};
    windowManager.i3.package = pkgs.i3-gaps;
    windowManager.i3.enable = true;
    videoDrivers = [ "nvidia" ];
    desktopManager.default = "none";
  };
 

  # i3 gaps
  environment.pathsToLink = [ "/libexec"  ]; # links /libexec from derivations to /run/current-system/sw

  nixpkgs.config = {
    pulseaudio = true;
    allowUnfree = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
	    };
	    emacs = pkgs.emacs.override { gtk = pkgs.gtk3;
	    	                          };
		};
	};


  # Define a user account. Don't forget to set a password with ‘passwd’.
   users.users.gtrun = {
     home = "/home/gtrun/";
     isNormalUser = true;
     extraGroups = [ "wheel" "audio" "pulse" "sound"]; # Enable ‘sudo’ for the user.
     shell = "/run/current-system/sw/bin/fish";
     uid = 1000;
     
   };


  # This value determines the NixOS release with which your system is to be
  # compatible, in order to avoid breaking some software such as database
  # servers. You should change this only after NixOS release notes say you
  # should.
  system.stateVersion = "19.03"; # Did you read the comment?

}
