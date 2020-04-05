{ config, pkgs, ... }:
  #inherit (pkgs)  libyaml libiconv;
with pkgs;
let
  my-python-packages = python-packages: with python-packages; [
    pylint
    scipy
    numpy
    ipython
    pyqt5
    qrcode
    pyqt5
    python-language-server
    #pymupdf
    xlib
    grip
    mypy
    flake8
    # other python packages you want
  ];
 python-with-my-packages = python37.withPackages my-python-packages;
in {
  # List packages installed in system profile. To search by name, run:
  # $ nix-env -qaP | grep wget
  environment.systemPackages = with pkgs; [
    python-with-my-packages
    #(python3.withPackages(ps: with ps; [ipykernel]))
  ];

}
 
