with import <nixpkgs> {};
 stdenv.mkDerivation {
  name = "env";
  buildInputs = [
    (pkgs.python3.withPackages (pkgs: with pkgs; [apache-airflow]))
  ];
}
