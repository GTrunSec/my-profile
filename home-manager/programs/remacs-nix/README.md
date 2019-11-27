# Nix Derivations for remacs

Nix derivations to build [remacs](https://github.com/remacs/remacs/ "remacs github repository").

- `default.nix` provides an environment to build remacs; optionally automated via direnv.

- `build.nix` provides a remacs derivation; remacs may either be built from github (the default) or from a local copy (may require a lot of memory).
