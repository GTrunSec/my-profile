{ lib, pkgs, config, inputs, ... }:

{
  home-manager.users.gtrun = { pkgs, config, ... }: {
    imports = [
      #lang
      ../darwin-profiles
      (inputs.nixos-flk + "/users/home-darwin.nix")
      #programs
    ];

  };

}
