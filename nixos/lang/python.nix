{ config, pkgs, ... }:
  #inherit (pkgs)  libyaml libiconv;
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pylint
    autopep8
    beautifulsoup4
    scipy
    numpy
    ipython
  ];
 python-with-my-packages = python37.withPackages my-python-packages;
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    python-with-my-packages
    (python3.withPackages(ps: with ps; [ipykernel]))
  ];
}
