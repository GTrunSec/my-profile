{
  description = "Guangtao's home-manager profile";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/75d69a0a27ee9262805e6a7a605f00e654b75a28";
    master.url = "nixpkgs/75d69a0a27ee9262805e6a7a605f00e654b75a28";
    home.url = "github:nix-community/home-manager/master";
    nixpkgs-hardenedlinux.url = "github:hardenedlinux/nixpkgs-hardenedlinux/master";
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  #outputs = inputs@{ self, nixpkgs, nixpkgs-hardenedlinux, master, flake-utils, emacs-overlay }:
  outputs = inputs: with builtins;let
      python-packages-overlay = (import "${inputs.nixpkgs-hardenedlinux}/nix/python-packages-overlay.nix");
      packages-overlay = (import "${inputs.nixpkgs-hardenedlinux}/nix/packages-overlay.nix");
      in
    (inputs.flake-utils.lib.eachDefaultSystem
        (system:
          let
            pkgs = import inputs.nixpkgs {
              inherit system;
              overlays = [
                python-packages-overlay
                packages-overlay
          ];
        };
          in
          {
            devShell = import ./devShell.nix { inherit pkgs; pkgsChannel = inputs.nixpkgs; homeChannel= inputs.home;};
          }
        )
    );
  }
