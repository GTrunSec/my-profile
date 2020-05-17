with import <nixpkgs> { };
let
  own-airflow = pkgs.callPackage /home/gtrun/project/hardenedlinux-zeek-script/NSM-data-analysis/pkgs/python/apache-airflow {};
in
stdenv.mkDerivation {
  name = "env";
    buildInputs = [
      own-airflow
    ];
}
