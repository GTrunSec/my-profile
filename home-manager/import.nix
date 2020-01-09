{ pkgs, config, substituteAll,... }:
{

  imports = [
    ./randr/work.nix
    ./setting
    #lang
    ./home-package.nix
    #programs
  ]; 
}
