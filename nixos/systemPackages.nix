{ pkgs, ... }:
{
environment.systemPackages = with pkgs; [
	   w3m
     fantasque-sans-mono
     polybar
     cmake
     home-manager
     gnumake
     git
     wget
     curl
     gnupg
     openssl
     killall
     chromium
     polar-bookshelf
     xdotool
     ditaa
     graphviz
   ];
}
