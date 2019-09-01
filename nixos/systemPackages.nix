{ config, lib, pkgs, vscode-utils, ... }:
let
  customVscode = (import ./custom/vscode.nix { inherit pkgs; });
in rec
  
  {

    
    hardware.brightnessctl.enable = true;
  environment.systemPackages = with pkgs; [
     customVscode
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
     # Unzip
     p7zip
     unzip
     zip
     pciutils    # lspci
     psmisc      # pkill, killall, pstree, fuser
     # rime
     librime
     fcitx-configtool
     #
     goldendict
     #
     qt5.qtbase
     #xdgrm
     virtmanager

     cargo
     rustup
     rustc
     #xbacklight

     #lang
     go
     go-langserver
     gocode
     go-outline
     go-symbols
     go2nix
     go-tools
     gocode-gomod
     godef
     gopkgs
     delve
     golint
  ];
  environment.variables = { GOROOT = [ "${pkgs.go.out}/share/go" ]; };
  
}
