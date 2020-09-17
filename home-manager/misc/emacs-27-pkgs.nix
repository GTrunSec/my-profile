let
  src = builtins.fetchTarball {
    url    = "https://github.com/NixOS/nixpkgs/tarball/9dfcba812aa0f4dc374acfe0600d591885f4e274";
    sha256 = "1r263c93ivwj9k7la3x988phsk8nypnxlszlzjky24wpym11s56z";
  };
in
import src
