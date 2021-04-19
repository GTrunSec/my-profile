{ config, lib, pkgs, ... }:
{

  programs.gpg = {
    enable = true;
    settings = {
      default-key = "B1A1304430618C3C";
      cert-digest-algo = "SHA512";
      disable-cipher-algo = "3DES";
      default-recipient-self = true;
      use-agent = true;
      with-fingerprint = true;
    };
  };


  programs.fzf = {
    enable = true;
    enableBashIntegration = true;
    enableZshIntegration = true;
  };


  home.file.".gnupg/gpg-agent.conf".text = ''
    enable-ssh-support
    pinentry-program ${pkgs.pinentry_mac}/Applications/pinentry-mac.app/Contents/MacOS/pinentry-mac
  '';

}
