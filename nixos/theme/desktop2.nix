{ config, pkgs, lib, ... } :
with lib;
let
  # themes = with pkgs; [
  # ];

  slim-theme = pkgs.fetchFromGitHub {
    owner = "ezemtsov";
    repo = "slim-theme";
    rev = "aa29ec80b550c709e3c5be14066e9c25948adf38";
    sha256 = "13xx75fcaqvwi5r3cb1cr928wh79h95cx606xmrmsvjb3bqjwwd2";
  };

in

{

  # programs.dconf.enable = true;
  # services.dbus.packages = [ pkgs.gnome3.dconf ];
  
  services.xserver = {
    enable = true;
    layout = "us";
    #desktopManager.plasma5.enable = true;
    #exportConfiguration = true;
    #desktopManager.deepin.enable = true;
    #desktopManager.deepin = {
     #  enable = true;
      # flashback.enableMetacity = true;
    #   flashback.customSessions = [
    #     { 
    #       wmCommand = "${pkgs.haskellPackages.xmonad}/bin/xmonad";
    #       wmLabel = "XMonad";
    #       wmName = "xmonad";
    #     }
       #   ];
  #  };
      desktopManager.default = "none";
      desktopManager.xterm.enable = false;

    # xterm.enable = false;
    # Enable touchpad support.
    # libinput.enable = true;
    displayManager.lightdm = {
      enable = true;
     # wayland = false;
#	    autoLogin = true;
 #     theme       = slim-theme;
#      defaultUser = "gtrun";
		};
#    
    windowManager = {
      i3 = {
        package = pkgs.i3-gaps;
        enable = true;
         # extraSessionCommands = ''
         #   ${pkgs.xlibs.xrdb}/bin/xrdb -load /etc/X11/Xresources
         # '';
      };
        default = "i3";
      # default = "xmonad";
      # xmonad = {
      #   enable = true;
      #   enableContribAndExtras = true;
      #   extraPackages = haskellPackages: [
      #     haskellPackages.xmonad-contrib
      #     haskellPackages.xmonad-extras
      #     haskellPackages.xmonad
      #   ];
      # };
    };
    videoDrivers = [ "nvidia" "amdgpu" "intel"];
    #    desktopManager.default = "Plasm";
  };
  hardware.nvidia.optimus_prime.enable = true;
  # Bus ID of the NVIDIA GPU. You can find it using lspci
  hardware.nvidia.optimus_prime.nvidiaBusId = "PCI:1:0:0";
  hardware.nvidia.optimus_prime.intelBusId = "PCI:0:2:0";
  # Bus ID of the Intel GPU. You can find it using lspci

    # i3 gaps
  environment.pathsToLink = [ "/libexec"  ]; # links /libexec from derivations to /run/current-system/sw

  nixpkgs.config = {
    pulseaudio = true;
    packageOverrides = pkgs: rec {
      polybar = pkgs.polybar.override {
        i3Support = true;
        githubSupport = true;
	    };
		};
	};

}


  
