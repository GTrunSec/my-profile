let
  nixpkgs = (import ~/.config/nixpkgs/channel/nixpkgs) { };
in
nixpkgs.buildEnv rec {
  name = "env";
    paths = [
      (nixpkgs.python38.withPackages (nixpkgs: with nixpkgs; [ apache-airflow
                                                    ]))
    ];
}
