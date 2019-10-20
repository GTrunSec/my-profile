nix-env --delete-generations 15d
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 15d
nix-collect-garbage
nix-store --optimize