{
  description = "Guangtao's home-manager profile";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/7ff5e241a2b96fff7912b7d793a06b4374bd846c";
    master.url = "nixpkgs";

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

            devShell = import ./shell.nix { inherit pkgs; pkgsChannel = inputs.nixpkgs;};

          }
        )
    );
  }
