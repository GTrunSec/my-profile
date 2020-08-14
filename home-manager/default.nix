{ ... }:

{

  imports = [
    ./setting
    #lang
    ./home-package.nix
    ./my3rd-scripts.nix
    ./home-files.nix
    ./home-darwin.nix
    ./misc
    ./programs
    ./python-pkgs.nix
    ../nixos-flk/users/password.nix
    #programs
  ];
}
