let
  nixpkgs = (import ~/.config/nixpkgs/nixos/channel/nixpkgs) { };
in
nixpkgs.buildEnv rec {
  name = "env";
    paths = [
      (nixpkgs.python3.withPackages (nixpkgs: with nixpkgs; [ nbconvert
                                                              bleach
                                                    ]))
    ];
}
