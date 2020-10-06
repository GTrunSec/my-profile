{ pkgs
, pkgsChannel
}:
let
  nixpkgs-locked = (builtins.fromJSON (builtins.readFile ./flake.lock)).nodes.nixpkgs.locked;
in
pkgs.mkShell {
  buildInputs = with pkgs;[
    home-manager
  ];
  shellHook = ''
    # nix-channel --add https://github.com/NixOS/nixpkgs/archive/${nixpkgs-locked.rev}.tar.gz nixpkgs
    # nix-channel --update
    home-manager build -f home.nix -I nixpkgs=${pkgsChannel}
    '';
}
