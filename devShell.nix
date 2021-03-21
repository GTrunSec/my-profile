{ pkgs
, pkgsChannel
, darwinChannel
, homeChannel
}:
let
  nixpkgs-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
  darwin-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.darwin.locked;
  home-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.home.locked;
in
pkgs.mkShell {
  buildInputs = with pkgs;[
  ];
  shellHook = ''
    nix-channel --add https://github.com/${home-locked.owner}/${home-locked.repo}/archive/${home-locked.rev}.tar.gz home-manager

    if [[ "$OSTYPE" == "linux-gnu" ]]; then
    nix-channel --add https://github.com/NixOS/nixpkgs/archive/${nixpkgs-locked.rev}.tar.gz nixpkgs
    nix-channel --update
    home-manager build -f home.nix -I nixpkgs=${pkgsChannel}
    elif [[ "$OSTYPE" == "darwin"* ]]; then
    nix-channel --add https://github.com/NixOS/nixpkgs/archive/${darwin-locked.rev}.tar.gz nixpkgs
    nix-channel --update
    home-manager build -f home.nix -I nixpkgs=${darwinChannel}
    fi
    exit
  '';
}
