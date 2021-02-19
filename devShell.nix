{ pkgs
, pkgsChannel
, homeChannel
}:
let
  nixpkgs-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
  home-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.home.locked;
in
pkgs.mkShell {
  buildInputs = with pkgs;[
  ];
  shellHook = ''
    nix-channel --add https://github.com/NixOS/nixpkgs/archive/${nixpkgs-locked.rev}.tar.gz nixpkgs
    nix-channel --add https://github.com/${home-locked.owner}/${home-locked.repo}/archive/${home-locked.rev}.tar.gz home-manager
    nix-channel --update
    home-manager build -f home.nix -I nixpkgs=${pkgsChannel}
    exit
  '';
}
