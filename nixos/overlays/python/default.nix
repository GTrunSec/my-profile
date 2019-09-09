with import <nixpkgs> {
  overlays = [ (import ../python.nix) ];
};

(python3.withPackages (ps: with ps; [
  bat
]))
