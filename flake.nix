{
  description = "Nix darwin Flake";

  inputs = {
    darwin = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:LnL7/nix-darwin/master";
    };
    home-manager = {
      inputs.nixpkgs.follows = "nixpkgs";
      url = "github:nix-community/home-manager/master";
    };

    nixos-flk = {
      url = "path:./nixos-flk";
      flake = false;
    };

    nixpkgs.url = "nixpkgs";


    flake-compat = { url = "github:edolstra/flake-compat"; flake = false; };

    emacs-overlay = { url = "github:nix-community/emacs-overlay/174ea8ba8f8a7b4f106f0a08c37d3f8af3bf94bb"; };
    devshell-flake.url = "github:numtide/devshell";
    flake-utils.url = "github:numtide/flake-utils";
  };

  outputs =
    { self
    , nixpkgs
    , home-manager
    , flake-utils
    , darwin
    , nixos-flk
    , flake-compat
    , emacs-overlay
    , devshell-flake
    , ...
    }:
    { } //
    (flake-utils.lib.eachSystem [ "x86_64-darwin" ]
      (system:
      let
        pkgs = import nixpkgs {
          overlays = [
            devshell-flake.overlay
          ];
          inherit system;
        };
      in
      rec {
        devShell = with pkgs; devshell.mkShell {
          imports = [
            (devshell.importTOML ./commands.toml)
          ];
        };
      })
    ) //
    {
      darwinConfigurations.gtrun-macbook =
        darwin.lib.darwinSystem
          {
            inputs = {
              inherit nixos-flk;
            };
            modules = [
              ./users/gtrun.nix
              ./darwin-profiles/core.nix
              home-manager.darwinModules.home-manager
              {
                nixpkgs.overlays = [
                  (import (nixos-flk + "/overlays/node-packages-overlay.nix"))
                  emacs-overlay.overlay
                ];
                nixpkgs.config = { allowUnsupportedSystem = true; };
              }
              {
                home-manager.useGlobalPkgs = true;
                home-manager.useUserPackages = true;
              }
            ];
          };
    }
    //
    { };
}
