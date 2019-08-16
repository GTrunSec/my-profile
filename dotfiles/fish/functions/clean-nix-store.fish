nix-env --delete-generations 30d
sudo nix-env -p /nix/var/nix/profiles/system --delete-generations 30d
nix-collect-garbage
nix-store --optimize