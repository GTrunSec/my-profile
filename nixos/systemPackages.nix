{ config, lib, pkgs, vscode-utils, ... }:
let
  customVscode = (import ./custom/vscode.nix { inherit pkgs; });
in rec
  
{
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
     ];
}
