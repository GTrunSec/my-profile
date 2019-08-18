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
     ];
}
