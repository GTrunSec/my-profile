#Enables bluetooth headset using bluez5 and pulseaudio
{ pkgs, ... }:
{
  hardware.bluetooth = {
    enable = true;
    powerOnBoot = true;
	  extraConfig = ''
	      ControllerMode = bredr
	      AutoConnect=true
	      [Headset]
	      HFP=true
	      MaxConnected=1
	      FastConnectable=true
	      '';
	};

  nixpkgs.config = {
    packageOverrides = pkgs: {
      bluez = pkgs.bluez5;
	  };
	};

  environment.systemPackages = [ pkgs.blueman ];

  hardware.pulseaudio.package = pkgs.pulseaudioFull;
}
