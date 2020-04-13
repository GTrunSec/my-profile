{ pkgs, config, substituteAll,... }:
{

  imports = [
    ./setting
    #lang
    ./home-package.nix
    ./my3rd-scripts.nix
    ./home-files.nix
    ./home-darwin.nix
    ./zeek-pkgs.nix
    #programs
  ];
}
