{
  description = "Guangtao's home-manager profile";

  inputs = {
    flake-utils.url = "github:numtide/flake-utils";
    nixpkgs.url = "nixpkgs/3a7674c896847d18e598fa5da23d7426cb9be3d2";
    darwin.url = "nixpkgs/7d71001b796340b219d1bfa8552c81995017544a";
    home.url = "github:nix-community/home-manager/release-20.09";
    nixpkgs-hardenedlinux = { url = "github:hardenedlinux/nixpkgs-hardenedlinux/master"; inputs.nixpkgs.follows = "nixpkgs"; };
    emacs-overlay.url = "github:nix-community/emacs-overlay";
  };

  outputs = inputs: with builtins;
    let
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
          devShell = import ./devShell.nix { inherit pkgs; darwinChannel = inputs.darwin; pkgsChannel = inputs.nixpkgs; homeChannel = inputs.home; };
        }
      )
    );
}
